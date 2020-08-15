import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();

  final Widget iconButton;
  ContactUsScreen({@required this.iconButton});
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
              'Contact Us',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
            child: TextField(
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter your message here',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: MaterialButton(
              onPressed: (){
                //TODO:CODE
              },
              padding: EdgeInsets.all(25),
              color: kColorYellow,
              child: Text(
                'Send  >',
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
    );
  }
}
