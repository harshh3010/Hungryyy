import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/dish_item.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/utilities/cart_api.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CartScreen extends StatefulWidget {

  static final String id = 'cart_screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  CartApi cartApi = CartApi.instance;
  UserApi userApi = UserApi.instance;
  String restaurantId;
  List<Widget> addedDishes = [];
  bool _loading = false;
  Widget restaurantCard;

  Future<void> setupCart() async {
    await openRestaurant();
    loadItems();
  }

  Future<void> openRestaurant() async {
    setState(() {
      _loading = true;
    });
    final http.Response response = await http.post(kOpenRestaurantUrl,body: {
      'city_name': userApi.cityName,
      'state_name' : userApi.stateName,
      'country_name' : userApi.countryName,
      'id' : restaurantId,
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
          restaurantCard = Container(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        restaurant.name,
                        style: kItemStyle.copyWith(fontSize: 24),
                      ),
                      Text(
                        '${restaurant.streetName}, ${restaurant.cityName}',
                        style: kItemStyle.copyWith(color: Colors.grey.shade500,fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(restaurant.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ],
            ),
          );
          _loading = false;
        });
      }
    }else{
      // Connection not established
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(context,'Unable to establish connection with the server');
    }
  }

  void loadItems(){
   List<String> productIds = [];
    List<Widget> myList = [];
    for(var map in cartApi.cartItems){
      Dish dish = map['product'];
      if(productIds.contains(dish.id)){
        continue;
      }else{
        productIds.add(dish.id);
        myList.add(
          DishItem(
            dish: dish,
            onDishAdded: (){},
            onDishRemoved:  (){},
          ),
        );
      }
    }
    setState(() {
      addedDishes = myList;
    });
  }

  @override
  void initState() {
    super.initState();
    if(cartApi.cartItems.isNotEmpty){
      restaurantId = cartApi.cartItems[0]['restaurant_id'];
    }else{
      setState(() {
        restaurantCard = Center(
          child: Text(
            'Cart is empty',
            style: kLabelStyle.copyWith(color: Colors.grey.shade500),
          ),
        );
      });
    }
    if(restaurantId != null){
      setupCart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _loading,
      color: Colors.white,
      opacity: .5,
      child: SafeArea(
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
                  onPressed: (){
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
                  'My Cart',
                  style: kHeadingStyle,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(child: restaurantCard),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: addedDishes,
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: (){
              if(cartApi.cartItems.isEmpty){
                AlertBox.showErrorBox(context,"Cart is empty");
              }else{
                //TODO:CODE
              }
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: kColorYellow,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Text(
                  'Place Order',
                  style: kLabelStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
