import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/screens/navigation_screens/search_page.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

class MyAddressScreen extends StatefulWidget {
  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();

  final Widget iconButton;
  final Function onAddressChange;
  MyAddressScreen({@required this.iconButton,@required this.onAddressChange});
}

class _MyAddressScreenState extends State<MyAddressScreen> {

  TextEditingController houseNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  String houseName,streetName,cityName,stateName,postalCode,countryName;
  double latitude,longitude;
  bool _loading = false;
  UserApi userApi = UserApi.instance;

  Future<void> saveUserData() async {
    final http.Response response = await http.post(kUpdateAddressUrl, body: {
      "email" : userApi.email,
      "house_name" : houseName,
      "street_name" : streetName,
      "city_name" : cityName,
      "state_name" : stateName,
      "postal_code" : postalCode,
      "country_name" : countryName,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == "SUCCESS"){
        // DATA STORED SUCCESSFULLY
        userApi.houseName = houseName;
        userApi.streetName = streetName;
        userApi.cityName = cityName;
        userApi.stateName = stateName;
        userApi.postalCode = postalCode;
        userApi.countryName = countryName;
        userApi.latitude = latitude;
        userApi.longitude = longitude;
        AlertBox.showSuccessBox(context, 'Address updated successfully', 'SUCCESS');
      }else if(data.toString() == "FAILED"){
        // UNABLE TO STORE DATA
        AlertBox.showErrorBox(context, 'Unable to update address');
      }
    }else{
      // Connection failed
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.\nError Code ${response.statusCode}');
    }
  }

  Future<void> getLocationFromAddress() async {
    final query = "$houseName, $streetName, $cityName, $stateName $postalCode, $countryName";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    latitude = first.coordinates.latitude;
    longitude = first.coordinates.longitude;
    print("$latitude AND  $longitude");
  }

  Future<void> getUserAddress() async {
    List<Placemark> newPlace = await Geolocator().placemarkFromCoordinates(latitude,longitude);

    Placemark placeMark  = newPlace[0];
    houseName = placeMark.name;
    streetName = placeMark.subLocality;
    cityName = placeMark.locality;
    stateName = placeMark.administrativeArea;
    postalCode = placeMark.postalCode;
    countryName = placeMark.country;

    print(houseName);
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;

    print("$latitude AND  $longitude");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: widget.iconButton,
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 27),
            child: Text(
              'My Address',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        color: Colors.white,
        opacity: .5,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
                      if(isLocationEnabled){
                        await getCurrentLocation();
                        await getUserAddress();
                        await saveUserData();
                        widget.onAddressChange();
                      }else{
                        AlertBox.showErrorBox(context,'Please turn on location services');
                      }
                      setState(() {
                        _loading = false;
                      });
                    },
                    padding: EdgeInsets.all(25),
                    color: kColorYellow,
                    child: Text(
                      'Proceed with current location >',
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: Text(
                    'Enter address manually',
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: CustomTextInput(
                    label: 'House Name/No.',
                    hint: 'Enter House Name/Number',
                    controller: houseNameController,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: CustomTextInput(
                    label: 'Street',
                    hint: 'Enter Street Name',
                    controller: streetNameController,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: CustomTextInput(
                    label: 'City',
                    hint: 'Enter City Name',
                    controller: cityNameController,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: CustomTextInput(
                    label: 'State',
                    hint: 'Enter State Name',
                    controller: stateNameController,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: CustomTextInput(
                    label: 'Postal Code',
                    hint: 'Enter Postal Code',
                    controller: postalCodeController,
                    textInputType: TextInputType.number,
                    isPasswordField: false,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: CustomTextInput(
                    label: 'Country',
                    hint: 'Enter Country Name',
                    controller: countryNameController,
                    textInputType: TextInputType.text,
                    isPasswordField: false,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      if(
                      houseNameController.text != "" &&
                          streetNameController.text != "" &&
                          cityNameController.text != "" &&
                          stateNameController.text != "" &&
                          postalCodeController.text != "" &&
                          countryNameController.text != ""
                      ){
                        houseName = houseNameController.text;
                        streetName = streetNameController.text;
                        cityName = cityNameController.text;
                        stateName = stateNameController.text;
                        postalCode = postalCodeController.text;
                        countryName = countryNameController.text;

                        await getLocationFromAddress();
                        await saveUserData();
                        widget.onAddressChange();
                      }else{
                        AlertBox.showErrorBox(context,'Please fill up all the fields');
                      }
                      setState(() {
                        _loading = false;
                      });
                    },
                    padding: EdgeInsets.all(25),
                    color: kColorYellow,
                    child: Text(
                      'Proceed  >',
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
