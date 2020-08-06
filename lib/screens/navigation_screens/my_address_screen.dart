import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class MyAddressScreen extends StatefulWidget {
  @override
  _MyAddressScreenState createState() => _MyAddressScreenState();

  final Widget iconButton;
  MyAddressScreen({@required this.iconButton});
}

class _MyAddressScreenState extends State<MyAddressScreen> {
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
              'My Address',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
    );
  }
}