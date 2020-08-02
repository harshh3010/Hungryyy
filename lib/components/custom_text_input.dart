import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class CustomTextInput extends StatelessWidget {

  final String label,hint;
  final IconData icon;
  final bool isPasswordField;
  final TextInputType textInputType;
  CustomTextInput({@required this.label,@required this.icon,@required this.hint,@required this.isPasswordField,@required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontFamily: 'GT Eesti',
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
        ),
        TextField(
          keyboardType: textInputType,
          obscureText: isPasswordField,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontFamily: 'GT Eesti',
              color: Colors.grey.shade400,
            ),
            icon: Icon(
              icon,
              color: Colors.grey.shade700,
              size: 16,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: kColorYellow,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}