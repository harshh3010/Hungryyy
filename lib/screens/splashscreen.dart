import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';

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
          child: HungryyyLogo(),
        ),
      ),
    );
  }
}
