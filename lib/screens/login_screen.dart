import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/screens/registration_screen.dart';
import 'package:hungryyy/services/local_storage.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'details_screen.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {

  static final String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool _loading = false;
  UserApi userApi = UserApi.instance;

  Future<void> loadUserDetails() async {
    final http.Response response = await http.post(kLoadUserDetailsUrl,body: {
      'email' : email.text,
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
      "email" : email.text,
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

  Future<void> loginUser() async {
    var data = {
      'email': email.text,
      'password' : password.text,
    };
    http.Response response = await http.post(kLoginUrl,body :(data));
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var message = jsonDecode(response.body.toString());
      if(message == 'Login Success'){
        // LOGIN SUCCESSFUL
        LocalStorage.saveLoginInfo(
          statusCode: 'YES',
          email: email.text,
        );
        await checkUserDetails();
      }else if(message == 'Login Failed'){
        // EMAIL OR PASSWORD DID NOT MATCH
        AlertBox.showErrorBox(context, 'Invalid email or password.');
      }
    }else{
      // Error connecting to the server
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      child: SafeArea(
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
                            label: 'Password',
                            hint: 'Your Password',
                            icon: Icons.lock_outline,
                            isPasswordField: true,
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: (){
                              //TODO: CODE
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'GT Eesti',
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              if(email.text != null && password.text != null && email.text != "" && password.text != ""){
                                await loginUser();
                              }else{
                                AlertBox.showErrorBox(context, 'Please fill up the required fields.');
                              }
                              setState(() {
                                _loading = false;
                              });
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
                                  Navigator.pushReplacementNamed(context,RegistrationScreen.id);
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
      ),
    );
  }
}