import 'package:flutter/material.dart';
import 'package:hungryyy/components/category_card.dart';
import 'package:hungryyy/components/most_popular_card.dart';
import 'package:hungryyy/components/restaurant_card.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/components/showcase_card.dart';
import 'package:hungryyy/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: IconButton(
                onPressed: () {
                  //TODO:CODE
                },
                padding: EdgeInsets.all(10),
                icon: Icon(
                  Icons.restaurant_menu,
                  color: kColorBlack,
                ),
              ),
            ),
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Deliver To',
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      color: kColorBlack,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Arera Colony, Bhopal, India  >',
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ],
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
                    Icons.person_outline,
                    color: kColorBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                child: Text(
                  'Find any Restaurant In',
                  style: kHeadingStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                child: Text(
                  'Your City 😉',
                  style: kHeadingStyle,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: SearchBox(
                  hint: 'Search Food',
                  onChanged: (value) {
                    //TODO:CODE
                  },
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ShowcaseCard(
                label: 'Categories',
                viewAll: () {
                  //TODO:CODE
                },
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      CategoryCard(
                        category: 'Snacks',
                        image: AssetImage('images/logo.png'),
                        onPressed: (){
                          //TODO:CODE
                        },
                      ),
                      CategoryCard(
                        category: 'Snacks',
                        image: AssetImage('images/logo.png'),
                        onPressed: (){
                          //TODO:CODE
                        },
                      ),
                      CategoryCard(
                        category: 'Snacks',
                        image: AssetImage('images/logo.png'),
                        onPressed: (){
                          //TODO:CODE
                        },
                      ),
                      CategoryCard(
                        category: 'Snacks',
                        image: AssetImage('images/logo.png'),
                        onPressed: (){
                          //TODO:CODE
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ShowcaseCard(
                label: 'Near You',
                viewAll: (){
                  //TODO:CODE
                },
                child: Container(
                  height: 270,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        RestaurantCard(
                          name: 'Pizza Hut',
                          deliveryCharge: 0,
                          distance: 2,
                          image: AssetImage('images/dish.jpg'),
                          rating: 4.5,
                        ),
                        RestaurantCard(
                          name: 'Manohar Dairy',
                          deliveryCharge: 50,
                          distance: 5,
                          image: AssetImage('images/dish.jpg'),
                          rating: 4.7,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ShowcaseCard(
                label: 'Most Popular',
                viewAll: (){
                  //TODO:CODE
                },
                child: MostPopularCard(
                  name: 'Blue Lagoon',
                  restaurantName: 'Dew Drops',
                  rating: 5,
                  image: AssetImage('images/dish.jpg'),
                  distance: 1.5,
                  deliveryCharge: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}