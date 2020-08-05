import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/services/local_storage.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class DetailsScreen2 extends StatefulWidget {
  @override
  _DetailsScreen2State createState() => _DetailsScreen2State();

  final String phoneNumber,name;
  DetailsScreen2({@required this.phoneNumber,@required this.name});
}

class _DetailsScreen2State extends State<DetailsScreen2> {

  TextEditingController houseName = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController cityName = TextEditingController();
  TextEditingController stateName = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController countryName = TextEditingController();
  String userEmail;

  Future<void> saveUserData() async {
    //TODO:ADD MORE DETAILS
    final http.Response response = await http.post(kSaveDetailsUrl, body: {
      "name": widget.name,
      "phone_number": widget.phoneNumber,
      "email" : userEmail,
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == "SUCCESS"){
        // DATA STORED SUCCESSFULLY
        await LocalStorage.saveUserDetails(
          name: widget.name,
          contactNumber: widget.phoneNumber,
        );
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }else if(data.toString() == "FAILED"){
        // UNABLE TO STORE DATA
        AlertBox.showErrorBox(context, 'Unable to store user data.');
      }
    }else{
      // Connection failed
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.\nError Code ${response.statusCode}');
    }
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
    return SafeArea(
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
                      //TODO:CODE
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
                    controller: houseName,
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
                    controller: streetName,
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
                    controller: cityName,
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
                    controller: stateName,
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
                    controller: postalCode,
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
                    controller: countryName,
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
                      //TODO:CODE
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
