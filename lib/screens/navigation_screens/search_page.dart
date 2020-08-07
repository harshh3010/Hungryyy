import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/category_card.dart';
import 'package:hungryyy/components/most_popular_card.dart';
import 'package:hungryyy/components/restaurant_card.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/components/showcase_card.dart';
import 'package:hungryyy/model/category.dart';
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

  List<Widget> categoriesToDisplay = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    ),
  ];
  bool displayCategories = true;
  UserApi userApi = UserApi.instance;

  Future<void> loadCategories() async {

    //TODO:LOAD CURRENT POSITION
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
                  //TODO:CODE
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
            displayCategories ?
                Column(
                  children: <Widget>[
                    ShowcaseCard(
                      label: 'Categories',
                      viewAll: () {
                        //TODO:CODE
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
    );
  }
}
