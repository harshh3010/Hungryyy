import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/dish_card.dart';
import 'package:hungryyy/components/filter_card.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/screens/restaurant_screen.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'cart_screen.dart';

class DishScreen extends StatefulWidget {
  @override
  _DishScreenState createState() => _DishScreenState();

  final String city, state, country,categoryId,popular;
  DishScreen(
      {@required this.city, @required this.state, @required this.country,@required this.categoryId,@required this.popular});
}

class _DishScreenState extends State<DishScreen> {

  UserApi userApi = UserApi.instance;
  String searchText;
  bool _loading = false;
  Map filterMap;
  Widget filterAppliedBar;

  List<Dish> allDishes = [];
  List<Dish> filteredDishes = [];
  List<Widget> dishesToDisplay = [];
  List<Widget> dishesToDisplayAll = [
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

  Future<void> loadDishes() async {
    allDishes = [];
    final http.Response response = await http.post(kLoadDishesUrl, body: {
      'city_name': widget.city,
      'state_name': widget.state,
      'country_name': widget.country,
      'category_id' : widget.categoryId,
      'popular' : widget.popular,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      // Connection established
      var data = jsonDecode(response.body.toString());
      if (data.toString() == 'Error loading data') {
        AlertBox.showErrorBox(context, 'Unable to load data');
      } else {
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
          print('unfiltered list');
          allDishes.add(dish);
        }
        generateDisplayWidget(allDishes);
      }
    } else {
      // Error establishing connection with the server
      AlertBox.showErrorBox(context,
          'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
    }
  }

  void generateDisplayWidget(List inputList){
    List<Widget> myList = [];
    for(var dish in inputList){
      myList.add(
        DishCard(
          dish: dish,
          onPressed: (){
            openRestaurant(dish);
          },
        ),
      );
    }
    setState(() {
      dishesToDisplayAll = myList;
    });
  }

  void showFilterCard() async {
    filterMap = await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enableDrag: true,
        builder: (BuildContext buildContext){
          return FilterCard();
        });

    print(filterMap);
    if(filterMap != null){
      filteredDishes = [];
      for(var dish in allDishes){
        if(applyFilter(filterMap,dish)){
          filteredDishes.add(dish);
        }
      }
      setState(() {
        filteredDishes = filteredDishes;
      });
      generateDisplayWidget(filteredDishes);
    }
  }

  bool applyFilter(Map filterMap,Dish dish){
    bool pricingFilter,ratingFilter,freeDeliveryFilter,offerFilter;
    switch(filterMap['pricing']){
      case Pricing.low : pricingFilter = dish.price <= 200;
      break;
      case Pricing.mid : pricingFilter = dish.price <= 400;
      break;
      case Pricing.high : pricingFilter = dish.price > 400;
      break;
      default : pricingFilter = true;
    }
    switch(filterMap['rating']){
      case Rating.low : ratingFilter = dish.rating <= 2;
      break;
      case Rating.mid : ratingFilter = dish.rating > 2 && dish.rating < 4;
      break;
      case Rating.high : ratingFilter = dish.rating > 4;
      break;
      default : ratingFilter = true;
    }
    if(filterMap['freeDelivery']){
      freeDeliveryFilter = dish.deliveryCharge == 0;
    }else{
      freeDeliveryFilter = true;
    }
    if(filterMap['offer']){
      offerFilter = dish.discount > 0;
    }else{
      offerFilter = true;
    }

    return (pricingFilter && ratingFilter && freeDeliveryFilter && offerFilter);
  }

  @override
  void initState() {
    super.initState();
    loadDishes();
  }

  @override
  Widget build(BuildContext context) {

    if(searchText == null){
      dishesToDisplay = dishesToDisplayAll;
    }
    if(filteredDishes.isEmpty){
      filteredDishes = allDishes;
    }

    if(filterMap != null){
      filterAppliedBar = Positioned(
        bottom: 0,
        left: 0,
        child: GestureDetector(
            onTap: (){
              setState(() {
                filterMap = null;
                generateDisplayWidget(allDishes);
              });
            },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
            decoration: BoxDecoration(
              color: kColorRed,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                'Filter applied. Tap to remove',
                style: kLabelStyle.copyWith(color: Colors.white,fontSize: 18),
              ),
            ),
          ),
        ),
      );
    }else{
      filterAppliedBar = Container();
    }

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
                      Navigator.pushReplacementNamed(context,CartScreen.id);
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
          body: Stack(
            children: <Widget>[
              Column(
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
                          List<Dish> filteredList = filteredDishes.where((dish) => dish.name.toLowerCase().contains(searchText)).toList();
                          List<Widget> myList = [];
                          for(var dish in filteredList){
                            myList.add(
                              DishCard(
                                dish: dish,
                                onPressed: (){
                                  openRestaurant(dish);
                                },
                              ),
                            );
                          }
                          setState(() {
                            dishesToDisplay = myList;
                          });
                        }
                      },
                      onPressed: (){
                        showFilterCard();
                      },
                    ),
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: loadDishes,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: dishesToDisplay,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              filterAppliedBar,
            ],
          ),
      ),
    );
  }
}
