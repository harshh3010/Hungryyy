import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/dish_card.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;

class DishScreen extends StatefulWidget {
  @override
  _DishScreenState createState() => _DishScreenState();

  final String city, state, country;
  DishScreen(
      {@required this.city, @required this.state, @required this.country});
}

class _DishScreenState extends State<DishScreen> {
  List<Widget> dishesToDisplay = [
    Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
          child: CircularProgressIndicator(
            strokeWidth: 4,
          ),
        ),
      ),
    ),
  ];

  Future<void> loadDishes() async {
    final http.Response response = await http.post(kLoadDishesUrl, body: {
      'city_name': widget.city,
      'state_name': widget.state,
      'country_name': widget.country,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Connection established
      var data = jsonDecode(response.body.toString());
      if (data.toString() == 'Error loading data') {
        AlertBox.showErrorBox(context, 'Unable to load data');
      } else {
        List<Widget> myList = [];
        for (Map map in data) {
          Dish dish = Dish(
            id: map['id'],
            name: map['name'],
            restaurantId: map['restaurant_id'],
            categoryId: map['category_id'],
            rating: double.parse(map['rating']),
            price: double.parse(map['price']),
            discount: double.parse(map['discount']),
            extraName: map['extra_name'],
            extraPrice: map['extra_price'],
            imageUrl: map['image_url'],
            cityName: map['city_name'],
            stateName: map['state_name'],
            countryName: map['country_name'],
            categoryName: map['category_name'],
            deliveryCharge: double.parse(map['delivery_charge']),
            restaurantName: map['restaurant_name'],
          );
          myList.add(
            DishCard(
              dish: dish,
            ),
          );
          setState(() {
            dishesToDisplay = myList;
          });
        }
        setState(() {
          dishesToDisplay = myList;
        });
      }
    } else {
      // Error establishing connection with the server
      AlertBox.showErrorBox(context,
          'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    loadDishes();
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
                  children: dishesToDisplay,
                ),
              ),
            ),
          ],
        ));
  }
}
