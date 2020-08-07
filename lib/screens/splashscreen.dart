import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/screens/login_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'details_screen.dart';
import 'menu_screen.dart';

class SplashScreen extends StatefulWidget {

  static final String id = 'spashscreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String loginState;
  String email;
  UserApi userApi = UserApi.instance;

  Future<void> loadUserDetails() async {
    final http.Response response = await http.post(kLoadUserDetailsUrl,body: {
      'email' : email,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context,'Unable to load user data.');
      }else{
        userApi.name = data[0]['name'];
        userApi.phoneNumber = int.parse(data[0]['phone_number']);
        userApi.houseName = data[0]['house_name'];
        userApi.streetName = data[0]['street_name'];
        userApi.cityName = data[0]['city_name'];
        userApi.stateName = data[0]['state_name'];
        userApi.postalCode = data[0]['postal_code'];
        userApi.countryName = data[0]['country_name'];
        userApi.email = data[0]['email'];
        userApi.id = int.parse(data[0]['id']);
      }
    }else{
      // Unable to establish connection
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.\nERROR CODE: ${response.statusCode}');
    }
  }

  Future<void> checkUserDetails() async {
    http.Response response = await http.post(kCheckUserDetailsUrl,body :{
      "email" : email,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var message = jsonDecode(response.body.toString());
      if(message == 'Data Present'){
        // User Details present
        await loadUserDetails();
        Navigator.pushReplacementNamed(context, MenuScreen.id);
      }else if(message == 'Data Absent'){
        // User Details absent
        Navigator.pushReplacementNamed(context, DetailsScreen.id);
      }
    }else{
      // Error connecting to the server
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.');
    }
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loginState = prefs.getString('login_status') ?? 'NO';
      email = prefs.getString('login_email') ?? null;
    });
    if(loginState == 'NO'){
      Navigator.pushReplacementNamed(context,LoginScreen.id);
    }else{
      await checkUserDetails();
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/background.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: HungryyyLogo(),
        ),
      ),
    );
  }
}

