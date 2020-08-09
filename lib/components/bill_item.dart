import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class BillItem extends StatelessWidget {

  final String labelText,valueText;
  BillItem({@required this.labelText,@required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            labelText,
            style: kLabelStyle,
          ),
          Text(
            valueText,
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }
}
