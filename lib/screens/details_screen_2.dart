import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/services/local_storage.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';
import 'menu_screen.dart';

class DetailsScreen2 extends StatefulWidget {
  @override
  _DetailsScreen2State createState() => _DetailsScreen2State();

  final String phoneNumber,name;
  DetailsScreen2({@required this.phoneNumber,@required this.name});
}

class _DetailsScreen2State extends State<DetailsScreen2> {

  TextEditingController houseNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController countryNameController = TextEditingController();
  String houseName,streetName,cityName,stateName,postalCode,countryName;
  String userEmail;
  double latitude,longitude;
  bool _loading = false;

  Future<void> saveUserData() async {
    final http.Response response = await http.post(kSaveDetailsUrl, body: {
      "name": widget.name,
      "phone_number": widget.phoneNumber,
      "email" : userEmail,
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
        await LocalStorage.saveUserDetails(
          name: widget.name,
          contactNumber: widget.phoneNumber,
          houseName: houseName,
          streetName: streetName,
          cityName: cityName,
          stateName: stateName,
          postalCode: postalCode,
          countryName: countryName,
        );
        Navigator.pushReplacementNamed(context, MenuScreen.id);
      }else if(data.toString() == "FAILED"){
        // UNABLE TO STORE DATA
        AlertBox.showErrorBox(context, 'Unable to store user data.');
      }
    }else{
      // Connection failed
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.\nError Code ${response.statusCode}');
    }
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
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;
  }

  Future<void> getLoginEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('login_email') ?? null;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginEmail();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                    child: Text(
                      'Address',
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
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

                          await saveUserData();
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
      ),
    );
  }
}
