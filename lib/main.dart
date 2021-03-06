import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungryyy/screens/cart_screen.dart';
import 'package:hungryyy/screens/details_screen.dart';
import 'package:hungryyy/screens/login_screen.dart';
import 'package:hungryyy/screens/menu_screen.dart';
import 'package:hungryyy/screens/registration_screen.dart';
import 'package:hungryyy/screens/splashscreen.dart';
import 'package:hungryyy/utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      title: 'Hungryyy App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kColorYellow,
        accentColor: kColorRed,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id : (context) => SplashScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        DetailsScreen.id : (context) => DetailsScreen(),
        MenuScreen.id : (context) => MenuScreen(),
        CartScreen.id : (context) => CartScreen(),
      },
    );
  }
}

