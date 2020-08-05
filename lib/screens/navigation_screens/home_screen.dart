import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungryyy/components/category_card.dart';
import 'package:hungryyy/components/drawer_item.dart';
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

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double rotationAngle = 0;
  bool isDrawerOpen = false;

  void animateScreen(){
    setState(() {
      xOffset = MediaQuery.of(context).size.width * .6;
      yOffset = MediaQuery.of(context).size.height*.33;
      rotationAngle = -20*3.14/180;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  void resetScreen(){
    setState(() {
      xOffset = 0;
      yOffset = 0;
      rotationAngle = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor)..rotateZ(rotationAngle),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: kColorBlack.withOpacity(0.1),
                offset: Offset(0,3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: !isDrawerOpen ? IconButton(
                    onPressed: () {
                      //TODO:CODE
                      animateScreen();
                    },
                    padding: EdgeInsets.all(10),
                    icon: Icon(
                      Icons.restaurant_menu,
                      color: kColorBlack,
                    ),
                  ) : IconButton(
                    onPressed: () {
                      //TODO:CODE
                      resetScreen();
                    },
                    padding: EdgeInsets.all(10),
                    icon: Icon(
                      Icons.arrow_back_ios,
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
                            category: 'Pizza',
                            image: AssetImage('images/category_pizza.png'),
                            onPressed: (){
                              //TODO:CODE
                            },
                          ),
                          CategoryCard(
                            category: 'Burger',
                            image: AssetImage('images/category_burger.png'),
                            onPressed: (){
                              //TODO:CODE
                            },
                          ),
                          CategoryCard(
                            category: 'Chinese',
                            image: AssetImage('images/category_chinese.png'),
                            onPressed: (){
                              //TODO:CODE
                            },
                          ),
                          CategoryCard(
                            category: 'Desserts',
                            image: AssetImage('images/category_dessert.png'),
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
        ),
      ),
    );
  }
}