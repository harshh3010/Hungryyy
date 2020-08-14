import 'package:flutter/material.dart';
import 'package:hungryyy/components/filter_card.dart';
import 'package:hungryyy/components/restaurant_card_big.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/screens/cart_screen.dart';
import 'package:hungryyy/utilities/constants.dart';

class AllRestaurantsScreen extends StatefulWidget {
  @override
  _AllRestaurantsScreenState createState() => _AllRestaurantsScreenState();

  final List<Restaurant> restaurants;
  AllRestaurantsScreen({@required this.restaurants});
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {

  String searchText;

  List<Widget> restaurantsToDisplay = [];
  List<Widget> restaurantsToDisplayAll = [
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
      restaurantsToDisplayAll = myList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  void showFilterCard(){
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enableDrag: true,
        builder: (BuildContext buildContext){
          return FilterCard();
        });
  }

  @override
  Widget build(BuildContext context) {

    if(searchText == null){
      restaurantsToDisplay = restaurantsToDisplayAll;
    }

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
                    Navigator.pushNamed(context,CartScreen.id);
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
                  if(value.toString().trim().isEmpty){
                    setState(() {
                      searchText = null;
                    });
                  }else{
                    searchText = value.toString().toLowerCase();
                    List<Restaurant> filteredList = widget.restaurants.where((restaurant) => restaurant.name.toLowerCase().contains(searchText)).toList();
                    List<Widget> myList = [];
                    for(var restaurant in filteredList){
                      myList.add(RestaurantCardBig(restaurant: restaurant));
                    }
                    setState(() {
                      restaurantsToDisplay = myList;
                    });
                  }
                },
                onPressed: (){
                  showFilterCard();
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
