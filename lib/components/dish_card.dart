import 'package:flutter/material.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/utilities/constants.dart';

class DishCard extends StatelessWidget {

  final Dish dish;
  final Function onPressed;
  DishCard({@required this.dish,@required this.onPressed});

  @override
  Widget build(BuildContext context) {

    String deliveryText;

    if(dish.deliveryCharge == 0){
      deliveryText = 'Free Delivery';
    }else{
      deliveryText = 'Rs. ${dish.deliveryCharge} Delivery Cost';
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        width: double.infinity,
        height: 230,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: kColorBlack.withOpacity(0.1),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(dish.imageUrl),
                      fit: BoxFit.cover
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
             dish.name,
              style: TextStyle(
                fontFamily: 'GT Eesti',
                fontSize: 20,
              ),
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.location_on,
                      color: kColorRed,
                      size: 12,
                    ),
                    Text(
                      dish.restaurantName,
                      style: TextStyle(
                        fontFamily: 'GT Eesti',
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '⭐ ',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '${dish.rating}',
                      style: TextStyle(
                          fontFamily: 'GT Eesti',
                          fontSize: 12
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.attach_money,
                  color: kColorRed,
                  size: 12,
                ),
                Text(
                  deliveryText,
                  style: TextStyle(
                    fontFamily: 'GT Eesti',
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}