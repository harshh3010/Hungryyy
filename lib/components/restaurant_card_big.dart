import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/screens/restaurant_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';

class RestaurantCardBig extends StatefulWidget {
  @override
  _RestaurantCardBigState createState() => _RestaurantCardBigState();

  final Restaurant restaurant;
  RestaurantCardBig({@required this.restaurant});
}

class _RestaurantCardBigState extends State<RestaurantCardBig> {

  UserApi userApi = UserApi.instance;
  double distance = 0;

  Future<void> calculateDistance() async{
    distance = await Geolocator().distanceBetween(widget.restaurant.latitude, widget.restaurant.longitude, userApi.latitude, userApi.longitude);
    distance = distance/1000;
    distance = distance.roundToDouble();

    setState(() {
      distance = distance;
    });
  }

  @override
  void initState() {
    super.initState();
    calculateDistance();
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
                      image: NetworkImage(widget.restaurant.imageUrl),
                      fit: BoxFit.cover
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.restaurant.name,
                  style: TextStyle(
                    fontFamily: 'GT Eesti',
                    fontSize: 20,
                  ),
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
                      '${widget.restaurant.rating}',
                      style: TextStyle(
                          fontFamily: 'GT Eesti',
                          fontSize: 12
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
          ],
        ),
      ),
    );
  }
}

