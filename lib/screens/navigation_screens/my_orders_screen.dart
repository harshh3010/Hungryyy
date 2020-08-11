import 'package:flutter/material.dart';
import 'package:hungryyy/model/order.dart';
import 'package:hungryyy/utilities/constants.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();

  final Widget iconButton;
  MyOrdersScreen({@required this.iconButton});
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
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
              'My Orders',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //TODO:ADD ORDER DISPLAY
          ],
        ),
      ),
    );
  }
}


