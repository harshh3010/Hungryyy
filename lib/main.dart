import 'package:flutter/material.dart';
import 'package:hungryyy/screens/login_screen.dart';
import 'package:hungryyy/screens/splashscreen.dart';
import 'package:hungryyy/utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kColorYellow,
        accentColor: kColorRed,
      ),
      initialRoute: LoginScreen.id,
      routes: {
        SplashScreen.id : (context) => SplashScreen(),
        LoginScreen.id : (context) => LoginScreen(),
      },
    );
  }
}

