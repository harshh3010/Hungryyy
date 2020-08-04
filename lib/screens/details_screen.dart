import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/screens/home_screen.dart';
import 'package:hungryyy/services/local_storage.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {

  static final String id = 'details_screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  bool _loading = false;
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();
  String userEmail;

  Future<void> saveUserData() async {
    //TODO:ADD MORE DETAILS
    final http.Response response = await http.post(kSaveDetailsUrl, body: {
      "name": name.text,
      "phone_number":phoneNumber.text,
      "email" : userEmail,
    });

    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == "SUCCESS"){
        // DATA STORED SUCCESSFULLY
        await LocalStorage.saveUserDetails(
            name: name.text,
            contactNumber: phoneNumber.text,
        );
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      }else if(data.toString() == "FAILED"){
        // UNABLE TO STORE DATA
        AlertBox.showErrorBox(context, 'Unable to store user data.');
      }
    }else{
      // Connection failed
      AlertBox.showErrorBox(context, 'Error establishing connection with the server.\nError Code ${response.statusCode}');
    }
  }

  Future<void> getLoginEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('login_email') ?? null;
    });
  }

  @override
  void initState() {
    super.initState();
    getLoginEmail();
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
                            controller: name,
                            label: 'Name',
                            hint: 'Name',
                            icon: Icons.person_outline,
                            isPasswordField: false,
                            textInputType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CustomTextInput(
                            controller: phoneNumber,
                            label: 'Contact',
                            hint: 'Your Contact Number (10 digits)',
                            icon: Icons.phone,
                            isPasswordField: false,
                            textInputType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          MaterialButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              if(name.text != null && phoneNumber.text != null && name.text != "" && phoneNumber.text != null){
                                await saveUserData();
                              }else{
                                AlertBox.showErrorBox(context, 'Please fill up the required fields');
                              }
                              setState(() {
                                _loading = false;
                              });
                            },
                            padding: EdgeInsets.all(25),
                            color: kColorYellow,
                            child: Text(
                              'Continue  >',
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
