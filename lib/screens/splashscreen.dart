import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungryyy/utilities/constants.dart';

class SplashScreen extends StatelessWidget {

  static final String id = 'spashscreen';

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[

              Image(
                image: AssetImage(
                    'images/logo.png',
                ),
                width: 100,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'HUNGRYYY',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'GT Eesti',
                  color: kColorBlack,
                  fontSize: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
