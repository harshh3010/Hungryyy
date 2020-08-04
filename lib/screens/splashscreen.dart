import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/screens/login_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'details_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {

  static final String id = 'spashscreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String loginState;
  String email;

  Future<void> checkUserDetails() async {
    http.Response response = await http.post(kCheckUserDetailsUrl,body :{
      "email" : email,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var message = jsonDecode(response.body.toString());
      if(message == 'Data Present'){
        // User Details present
        Navigator.pushReplacementNamed(context, HomeScreen.id);
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

