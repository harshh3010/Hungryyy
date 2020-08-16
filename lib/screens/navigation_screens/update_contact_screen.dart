import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UpdateContactScreen extends StatefulWidget {
  @override
  _UpdateContactScreenState createState() => _UpdateContactScreenState();

  final Widget iconButton;
  UpdateContactScreen({@required this.iconButton});
}

class _UpdateContactScreenState extends State<UpdateContactScreen> {

  UserApi userApi = UserApi.instance;
  bool _loading = false;
  TextEditingController phoneNumber = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();

  Future<void> verifyOTP() async {
    setState(() {
      _loading = true;
    });
    final http.Response response = await http.post(kVerifyOtpUrl,body: {
      'mobile' : phoneNumber.text,
      'otp' : _codeController.text,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'FAILED'){
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context,'Verification failed');
      }else{
        setState(() {
          _loading = false;
          userApi.phoneNumber = int.parse(phoneNumber.text);
        });
        AlertBox.showSuccessBox(context, 'Phone number updated', 'Success');
      }
    }else{
      AlertBox.showErrorBox(context,'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
    }
  }

  Future<void> sendOTP() async {
    setState(() {
      _loading = true;
    });
    final http.Response response = await http.post(kSendOtpUrl,body: {
      'mobile' : phoneNumber.text,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'OTP Not Sent'){
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context, 'Unable to send OTP');
      }else if(data.toString() == 'ERROR'){
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context, 'An error occurred. We are sorry, the verification cannot be completed.');
      }else{
        setState(() {
          _loading = false;
        });
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Phone Verification"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('We have sent you an OTP on the entered phone number, please verify the OTP to continue.'),
                TextField(
                  controller: _codeController,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                textColor: Colors.white,
                color: kColorYellow,
                onPressed: () {
                  Navigator.pop(context);
                  verifyOTP();
                },
              )
            ],
          ),
        );
      }
    }else{
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(context,'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
            child: widget.iconButton,
          ),
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 27),
            child: Text(
              'Update Contact',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        color: Colors.white,
        opacity: .5,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Your current contact number is +91 ${userApi.phoneNumber}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'GT Eesti',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: CustomTextInput(
                  controller: phoneNumber,
                  label: 'Contact',
                  hint: 'Your Contact Number (10 digits)',
                  icon: Icons.phone,
                  isPasswordField: false,
                  textInputType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      _loading = true;
                    });
                    if(phoneNumber.text != null){
                      sendOTP();
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
                    'Update Contact  >',
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}