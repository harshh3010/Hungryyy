import 'package:flutter/material.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/screens/login_screen.dart';
import 'package:hungryyy/utilities/constants.dart';

class RegistrationScreen extends StatefulWidget {

  static final String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
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
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                  child: Material(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        CustomTextInput(
                          label: 'Email',
                          hint: 'Your Email',
                          icon: Icons.person_outline,
                          isPasswordField: false,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextInput(
                          label: 'Create Password',
                          hint: 'Create a Password',
                          icon: Icons.lock_outline,
                          isPasswordField: true,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CustomTextInput(
                          label: 'Confirm Password',
                          hint: 'Confirm your Password',
                          icon: Icons.lock_outline,
                          isPasswordField: true,
                          textInputType: TextInputType.text,
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
                            'Sign Up  >',
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
                              'Already have an account?',
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
                                Navigator.pushReplacementNamed(context, LoginScreen.id);
                              },
                              child: Text(
                                'Sign In',
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
