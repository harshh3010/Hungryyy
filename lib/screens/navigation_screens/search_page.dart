import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/category_card.dart';
import 'package:hungryyy/components/dish_card.dart';
import 'package:hungryyy/components/restaurant_card.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/components/showcase_card.dart';
import 'package:hungryyy/model/category.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/screens/cart_screen.dart';
import 'package:hungryyy/screens/dish_screen.dart';
import 'package:hungryyy/screens/all_restaurants_screen.dart';
import 'package:hungryyy/screens/restaurant_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  bool displayMostPopular = true;
  Widget mostPopularDish = Padding(
    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
    child: CircularProgressIndicator(
      strokeWidth: 4,
    ),
  );
  UserApi userApi = UserApi.instance;
  bool _loading = false;

  Future<void> openRestaurant(Dish dish) async {
    setState(() {
      _loading = true;
    });
    final http.Response response = await http.post(kOpenRestaurantUrl,body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
      'id' : dish.restaurantId,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context,'Unable to get the restaurant information');
      }else{
        Restaurant restaurant = Restaurant(
          id: data[0]['id'],
          name: data[0]['name'],
          streetName: data[0]['street_name'],
          cityName: data[0]['city_name'],
          stateName: data[0]['state_name'],
          postalCode: data[0]['postal_code'],
          countryName: data[0]['country_name'],
          phoneNumber: data[0]['phone_number'],
          latitude: double.parse(data[0]['latitude']),
          longitude: double.parse(data[0]['longitude']),
          rating: double.parse(data[0]['rating']),
          imageUrl: data[0]['image_url'],
          deliveryCharge: double.parse(data[0]['delivery_charge']),
        );
        setState(() {
          _loading = false;
        });
        //TODO:ADD DISH
        Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantScreen(restaurant: restaurant,specificDish: dish)));
      }
    }else{
      // Connection not established
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
    }
  }

  Future<void> loadMostPopular() async {
    final http.Response response = await http.post(kMostPopularDishUrl,body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context,'Unable to load popular food near you');
        setState(() {
          displayMostPopular = false;
        });
      }else{
        Dish dish = Dish(
          id: data[0]['id'],
          name: data[0]['name'],
          restaurantId: data[0]['restaurant_id'],
          categoryId: data[0]['category_id'],
          rating: double.parse(data[0]['rating']),
          price: double.parse(data[0]['price']),
          discount: double.parse(data[0]['discount']),
          extraName: data[0]['extra_name'],
          extraPrice: data[0]['extra_price'],
          imageUrl: data[0]['image_url'],
          cityName: data[0]['city_name'],
          stateName: data[0]['state_name'],
          countryName: data[0]['country_name'],
          categoryName: data[0]['category_name'],
          deliveryCharge: double.parse(data[0]['delivery_charge']),
          restaurantName: data[0]['restaurant_name'],
        );
        setState(() {
          mostPopularDish = DishCard(
            dish: dish,
            onPressed: (){
              openRestaurant(dish);
            },
          );
        });
        if(dish == null){
          setState(() {
            displayMostPopular = false;
          });
        }
      }
    }else{
      // Connection not established
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
      setState(() {
        displayMostPopular = false;
      });
    }
  }

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
        AlertBox.showErrorBox(context,'Unable to load restaurants near you.');
        setState(() {
          displayRestaurants = false;
        });
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
        if(myList.isEmpty){
          setState(() {
            displayRestaurants = false;
          });
        }else{
          setState(() {
            restaurantsToDisplay = myList;
          });
        }
      }
    }else{
      // Connection not established
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
      setState(() {
        displayRestaurants = false;
      });
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
                      popular: 'NO',
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
    loadMostPopular();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      child: Scaffold(
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
                                popular: 'NO',
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
                              builder: (context) => AllRestaurantsScreen(restaurants: allRestaurants,),
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
              ShowcaseCard(
                label: 'Most Popular',
                viewAll: (){
                  Navigator.push(context,MaterialPageRoute(
                    builder: (context) => DishScreen(
                      city: userApi.cityName,
                      state: userApi.stateName,
                      country: userApi.countryName,
                      categoryId: 'none',
                      popular: 'YES',
                    ),
                  ));
                },
                child: mostPopularDish,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
