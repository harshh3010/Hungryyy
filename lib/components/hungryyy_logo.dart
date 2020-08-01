import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class HungryyyLogo extends StatelessWidget {
  const HungryyyLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image(
          image: AssetImage(
            'images/logo.png',
          ),
          width: 100,
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          'HUNGRYYY',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'GT Eesti',
            color: kColorBlack,
            fontSize: 36,
          ),
        ),
      ],
    );
  }
}