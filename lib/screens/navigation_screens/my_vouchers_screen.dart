import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class MyVouchersScreen extends StatefulWidget {
  @override
  _MyVouchersScreenState createState() => _MyVouchersScreenState();

  final Widget iconButton;
  MyVouchersScreen({@required this.iconButton});
}

class _MyVouchersScreenState extends State<MyVouchersScreen> {
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
              'My Vouchers',
              style: kHeadingStyle,
            ),
          ),
        ),
      ),
    );
  }
}
