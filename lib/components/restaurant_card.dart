import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/screens/restaurant_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';

class RestaurantCard extends StatefulWidget {
  @override
  _RestaurantCardState createState() => _RestaurantCardState();

  final Restaurant restaurant;
  RestaurantCard({@required this.restaurant});
}

class _RestaurantCardState extends State<RestaurantCard> {

  double distance = 0;
  UserApi userApi = UserApi.instance;

  Future<void> calculateDistance() async{
    distance = await Geolocator().distanceBetween(widget.restaurant.latitude, widget.restaurant.longitude, userApi.latitude, userApi.longitude);
    distance = distance/1000;
    distance = distance.roundToDouble();

    setState(() {
      distance = distance;
    });
  }

  @override
  Widget build(BuildContext context) {

    String deliveryText;

    if(widget.restaurant.deliveryCharge == 0){
      deliveryText = 'Free Delivery';
    }else{
      deliveryText = 'Rs. ${widget.restaurant.deliveryCharge} Delivery Cost';
    }

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => RestaurantScreen(restaurant: widget.restaurant,),
        ),);
      },
      child: Container(
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
                      image: NetworkImage(widget.restaurant.imageUrl),
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
              widget.restaurant.name,
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
                  '${widget.restaurant.rating}',
                  style: TextStyle(
                      fontFamily: 'GT Eesti',
                      fontSize: 12
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
