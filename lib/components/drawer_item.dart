import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class DrawerItem extends StatelessWidget {

  final String label;
  final IconData icon;
  final Function onPressed;
  DrawerItem({@required this.label,@required this.icon,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Icon(
              icon,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            label,
            style: kItemStyle,
          ),
        ],
      ),
    );
  }
}