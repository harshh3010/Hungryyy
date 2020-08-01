import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/utilities/constants.dart';

class LoginScreen extends StatefulWidget {

  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                HungryyyLogo(),
                SizedBox(
                  height: 60,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CustomTextInput(
                          label: 'Name',
                          hint: 'Your Name',
                          icon: Icons.person_outline,
                          isPasswordField: false,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextInput(
                          label: 'Password',
                          hint: 'Your Password',
                          icon: Icons.lock_outline,
                          isPasswordField: true,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontFamily: 'GT Eesti',
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        MaterialButton(
                          onPressed: (){
                            //TODO:CODE
                          },
                          padding: EdgeInsets.all(25),
                          color: kColorYellow,
                          child: Text(
                            'Log In  >',
                            style: TextStyle(
                              fontFamily: 'GT Eesti',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontFamily: 'GT Eesti',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            GestureDetector(
                              onTap: (){
                                //TODO: CODE
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'GT Eesti',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: kColorRed
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
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