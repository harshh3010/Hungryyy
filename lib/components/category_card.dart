import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class CategoryCard extends StatelessWidget {

  final String category;
  final ImageProvider image;
  final Function onPressed;
  CategoryCard({@required this.category,@required this.image,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(30),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: kColorYellow,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: kColorBlack.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: image,
              height: 40,
              width: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              category,
              style: TextStyle(
                fontFamily: 'GT Eesti',
              ),
            )
          ],
        ),
      ),
    );
  }
}