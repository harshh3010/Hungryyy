import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/screens/login_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {

  static final String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController cnfPassword = new TextEditingController();

  Future<void> registerUser() async {
    final http.Response response = await http.post(kRegisterUrl, body: {
      "email": email.text,
      "password":password.text,
    });
    print(response.statusCode);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      if(data.toString() == "User exists"){
        AlertBox.showErrorBox(context, 'This email is already in use.');
      }else if(data.toString() == "User registered"){
        // TODO:AFTER SUCCESS
      }
    }else{
      print(response.statusCode);
      print('Error connecting to the server');
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.');
    }

  }

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
                          controller: email,
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
                          controller: password,
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
                          controller: cnfPassword,
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
                          onPressed: () async {
                            if(password.text != null && email.text != null){
                              if(cnfPassword.text == password.text){
                                await registerUser();
                              }else{
                                AlertBox.showErrorBox(context, 'The confirmation password did not match with the chosen one.');
                              }
                            }else{
                              AlertBox.showErrorBox(context, 'Please fill up all the fields.');
                            }
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
