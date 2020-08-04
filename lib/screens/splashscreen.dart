import 'package:flutter/material.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details_screen.dart';

class SplashScreen extends StatefulWidget {

  static final String id = 'spashscreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String loginState;

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    loginState = prefs.getString('login_status') ?? 'NO';
    if(loginState == 'NO'){
      Navigator.pushReplacementNamed(context,LoginScreen.id);
    }else{
      //TODO:CHECK DETAILS
      Navigator.pushReplacementNamed(context,DetailsScreen.id);
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

