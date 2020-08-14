import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class SearchBox extends StatelessWidget {

  final String hint;
  final Function onChanged,onPressed;
  SearchBox({@required this.hint,@required this.onChanged,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: kColorBlack.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ]),
      child: Row(
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Center(
              child: Icon(
                  Icons.search,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontFamily: 'GT Eesti',
                      color: Colors.grey.shade400,
                    ),
                    border: InputBorder.none,
                ),
                cursorColor: kColorRed,
              ),
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: kColorYellow,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Center(
                child: Icon(Icons.tune),
              ),
            ),
          ),
        ],
      ),
    );
  }
}