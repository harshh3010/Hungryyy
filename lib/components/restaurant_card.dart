import 'package:flutter/material.dart';
import 'package:hungryyy/utilities/constants.dart';

class RestaurantCard extends StatelessWidget {

  final String name;
  final double distance,deliveryCharge,rating;
  final ImageProvider image;
  RestaurantCard({@required this.name,@required this.distance,@required this.deliveryCharge,@required this.rating,@required this.image});

  @override
  Widget build(BuildContext context) {

    String deliveryText;

    if(deliveryCharge == 0){
      deliveryText = 'Free Delivery';
    }else{
      deliveryText = 'Rs. $deliveryCharge Delivery Cost';
    }

    return Container(
      width: 170,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
              fontFamily: 'GT Eesti',
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Wrap(
            direction: Axis.horizontal,
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
                    '$distance km',
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text(
                  ' • '
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
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Wrap(
            direction: Axis.horizontal,
            children: <Widget>[
              Text(
                '⭐ ',
                style: TextStyle(
                  fontSize: 10,
                ),
              ),
              Text(
                '$rating',
                style: TextStyle(
                    fontFamily: 'GT Eesti',
                    fontSize: 12
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}