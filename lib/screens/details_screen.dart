
import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/custom_text_input.dart';
import 'package:hungryyy/components/hungryyy_logo.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'details_screen_2.dart';

class DetailsScreen extends StatefulWidget {

  static final String id = 'details_screen';

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  bool _loading = false;
  TextEditingController name = new TextEditingController();
  TextEditingController phoneNumber = new TextEditingController();

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
                                //TODO:VERIFY PHONE
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailsScreen2(name: name.text,phoneNumber: phoneNumber.text,)));
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
