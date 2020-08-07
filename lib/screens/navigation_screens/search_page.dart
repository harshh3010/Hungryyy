import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/category_card.dart';
import 'package:hungryyy/components/restaurant_card.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/components/showcase_card.dart';
import 'package:hungryyy/model/category.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/screens/dish_screen.dart';
import 'package:hungryyy/screens/restaurant_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();

  final Widget iconButton;
  SearchPage({@required this.iconButton});
}

class _SearchPageState extends State<SearchPage> {

  //TODO:LOAD CURRENT POSITION
  List<Widget> categoriesToDisplay = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    ),
  ];
  List<Widget> restaurantsToDisplay = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    ),
  ];
  List<Restaurant> allRestaurants = [];
  bool displayCategories = true;
  bool displayRestaurants = true;
  UserApi userApi = UserApi.instance;

  Future<void> loadRestaurants() async {
    final http.Response response = await http.post(kLoadRestaurantsUrl,body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context,'Unable to load categories of food near you.');
      }else{
        List<Widget> myList = [];
        for(Map map in data){
          Restaurant restaurant = Restaurant(
            id: map['id'],
            name: map['name'],
            streetName: map['street_name'],
            cityName: map['city_name'],
            stateName: map['state_name'],
            postalCode: map['postal_code'],
            countryName: map['country_name'],
            phoneNumber: map['phone_number'],
            latitude: double.parse(map['latitude']),
            longitude: double.parse(map['longitude']),
            rating: double.parse(map['rating']),
            imageUrl: map['image_url'],
            deliveryCharge: double.parse(map['delivery_charge']),
          );
          allRestaurants.add(restaurant);
        }
        int n = 0;
        for(var restaurant in allRestaurants){
          n++;
          if(n == 5){
            break;
          }
          myList.add(
            RestaurantCard(
              restaurant: restaurant,
            ),
          );
          setState(() {
            restaurantsToDisplay = myList;
          });
        }
        setState(() {
          restaurantsToDisplay = myList;
        });
      }
    }else{
      // Connection not established
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
    }
  }

  Future<void> loadCategories() async {
    final http.Response response = await http.post(kLoadCategoriesUrl,body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context,'Unable to load categories of food near you.');
        setState(() {
          displayCategories = false;
        });
      }else{
        List<Widget> myList = [];
        for(Map map in data){
          Category category = Category(
            name: map['category_name'],
            id: map['category_id'],
          );
          if(category.id != 'category_other'){
            myList.add(
              CategoryCard(
                category: category,
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(
                    builder: (context) => DishScreen(
                      city: userApi.cityName,
                      state: userApi.stateName,
                      country: userApi.countryName,
                      categoryId: category.id,
                    ),
                  ));
                },
              ),
            );
          }
        }
        if(myList.isEmpty){
          setState(() {
            displayCategories = false;
          });
        }else{
          setState(() {
            displayCategories = true;
            categoriesToDisplay = myList;
          });
        }
      }
    }else{
      // Connection not established
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
      setState(() {
        displayCategories = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadCategories();
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
            child: widget.iconButton,
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
                  '${userApi.streetName}, ${userApi.cityName} >',
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
            displayCategories ?
                Column(
                  children: <Widget>[
                    ShowcaseCard(
                      label: 'Categories',
                      viewAll: () {
                        //TODO:UPDATE CURRENT LOCATION
                        Navigator.push(context,MaterialPageRoute(
                            builder: (context) => DishScreen(
                              city: userApi.cityName,
                              state: userApi.stateName,
                              country: userApi.countryName,
                              categoryId: 'none',
                            ),
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20)  ,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoriesToDisplay,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                )
                : Container(),
            displayRestaurants ?
                Column(
                  children: <Widget>[
                    ShowcaseCard(
                      label: 'Near You',
                      viewAll: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantScreen(restaurants: allRestaurants,),
                          ),
                        );
                      },
                      child: Container(
                        height: 270,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: restaurantsToDisplay,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ):Container(),


//TODO: ADD MOST POPULAR
//            ShowcaseCard(
//              label: 'Most Popular',
//              viewAll: (){
//                //TODO:CODE
//              },
//              child: DishCard(
//                dish: Dish(),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
