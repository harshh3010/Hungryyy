import 'package:flutter/material.dart';
import 'package:hungryyy/components/restaurant_card_big.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/utilities/constants.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();

  final List<Restaurant> restaurants;
  RestaurantScreen({@required this.restaurants});
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  List<Widget> restaurantsToDisplay = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    ),
  ];

  void loadRestaurants(){
    List<Widget> myList = [];
    for(var restaurant in widget.restaurants){
      myList.add(RestaurantCardBig(restaurant: restaurant));
    }
    setState(() {
      restaurantsToDisplay = myList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.all(10),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: kColorBlack,
                ),
              ),
            ),
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Text(
                'HUNGRYYY',
                style: kHeadingStyle,
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: IconButton(
                  onPressed: () {
                    //TODO:CODE
                  },
                  padding: EdgeInsets.all(10),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: kColorBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              child: SearchBox(
                hint: 'Search Food',
                onChanged: (value) {
                  //TODO:CODE
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: restaurantsToDisplay,
                ),
              ),
            ),
          ],
        ));
  }
}
