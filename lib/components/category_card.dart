import 'package:flutter/material.dart';
import 'package:hungryyy/model/category.dart';
import 'package:hungryyy/utilities/constants.dart';

class CategoryCard extends StatelessWidget {

  final Category category;
  final Function onPressed;
  CategoryCard({@required this.category,@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: kColorYellow,
          borderRadius: const BorderRadius.all(const Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: kColorShadow,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/${category.id}.png'),
              height: 40,
              width: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              category.name,
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