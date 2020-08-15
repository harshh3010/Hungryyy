import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();

  final Widget iconButton;
  HelpScreen({@required this.iconButton});
}

class _HelpScreenState extends State<HelpScreen> {

  _launchURL() async {
    const url = 'mailto:harsh.gyanchandani@gmail.com?subject=Hungryy App Help';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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
              'Help',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'This app has been developed by Harsh Gyanchandani ©2020',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'GT Eesti',
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'For any queries contact',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'GT Eesti',
            ),
          ),
          GestureDetector(
            onTap: _launchURL,
            child: Text(
              'harsh.gyanchandani@gmail.com',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'GT Eesti',
                color: kColorRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
