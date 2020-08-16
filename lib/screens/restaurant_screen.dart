import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/dish_item.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/utilities/cart_api.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'cart_screen.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();

  final Restaurant restaurant;
  final Dish specificDish;
  RestaurantScreen({@required this.restaurant,this.specificDish});
}

class _RestaurantScreenState extends State<RestaurantScreen> with TickerProviderStateMixin {

  AnimationController _colorAnimationController;
  AnimationController _textAnimationController;
  Animation _colorTween, _iconColorTween;
  Animation<Offset> _transTween;
  bool emptyCart = true;
  Widget addedToCartBar;
  CartApi cartApi = CartApi.instance;
  Widget specificDishToDisplay;

  List<Widget> categoriesToDisplay = [
    Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          child: CircularProgressIndicator(
            strokeWidth: 4,
          ),
        ),
      ),
    ),
  ];

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 180);

      _textAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 180) / 50);
      return true;
    } else {
      return false;
    }
  }

  Future<void> loadRestaurantMenu() async {
    final http.Response response =
        await http.post(kLoadRestaurantMenuUrl, body: {
      'restaurant_id': widget.restaurant.id,
    });
    if (response.statusCode == 201 || response.statusCode == 200) {
      // Connection established
      var data = jsonDecode(response.body.toString());
      if (data == 'Error loading data') {
        AlertBox.showErrorBox(context, "Unable to load restaurant menu");
      } else {
        var categoryGroups = groupBy(data, (obj) => obj['category_name']);
        List<Widget> myList = [];
        for (var entry in categoryGroups.entries) {
          List<Widget> dishesToDisplay = [];
          for (var map in entry.value) {
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
            dishesToDisplay.add(
              DishItem(
                dish: dish,
                onDishAdded: (){
                  setState(() {
                    emptyCart = false;
                  });
                },
                onDishRemoved: (){
                  setState(() {
                    emptyCart = true;
                  });
                },
              ),
            );
          }
          myList.add(
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  '${entry.key}',
                  style: kLabelStyle,
                ),
                Column(
                  children: dishesToDisplay,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
          setState(() {
            categoriesToDisplay = myList;
          });
        }
        setState(() {
          categoriesToDisplay = myList;
        });
      }
    } else {
      // Unable to establish connection
      AlertBox.showErrorBox(context,
          "Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}");
    }
  }

  _launchURL() async {
    String url = 'tel:+91 ${widget.restaurant.phoneNumber}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    _colorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_colorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: kColorBlack)
        .animate(_colorAnimationController);

    _textAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_textAnimationController);

    super.initState();
    loadRestaurantMenu();
  }

  @override
  Widget build(BuildContext context) {

    if(widget.specificDish != null){
      specificDishToDisplay = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Order Now',
            style: kItemStyle.copyWith(fontSize: 30),
          ),
          DishItem(
            dish: widget.specificDish,
            onDishAdded: (){
              setState(() {
                emptyCart = false;
              });
            },
            onDishRemoved: (){
              setState(() {
                emptyCart = true;
              });
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'More from',
            style: kItemStyle,
          ),
          Text(
            widget.restaurant.name,
            style: kItemStyle.copyWith(fontSize: 30),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      );
    }

    if(!emptyCart || cartApi.cartItems.isNotEmpty){
      String itemText;
      if(cartApi.cartItems.length == 1)
        itemText = '1 item';
      else itemText = '${cartApi.cartItems.length} items';
      addedToCartBar = Positioned(
        bottom: 0,
        left: 0,
        child: GestureDetector(
          onTap: (){
            Navigator.pushReplacementNamed(context,CartScreen.id);
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
                '$itemText added to cart. Click to view',
                style: kLabelStyle.copyWith(color: Colors.white,fontSize: 18),
              ),
            ),
          ),
        ),
      );
    }else{
      addedToCartBar = Container();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              RefreshIndicator(
                onRefresh: loadRestaurantMenu,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(30, 200, 30, 50),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.restaurant.imageUrl),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                kColorBlack.withOpacity(0.4), BlendMode.srcATop),
                          ),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              widget.restaurant.name,
                              style: kHeadingStyle.copyWith(
                                  color: Colors.white, fontSize: 30),
                            ),
                            Text(
                              '${widget.restaurant.streetName}, ${widget.restaurant.cityName}',
                              style: kLabelStyle.copyWith(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: specificDishToDisplay,
                            ),
                            Column(
                              children: categoriesToDisplay,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                child: AnimatedBuilder(
                  animation: _colorAnimationController,
                  builder: (context, child) => AppBar(
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.all(10),
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),
                    ),
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    titleSpacing: 0.0,
                    centerTitle: true,
                    title: Transform.translate(
                      offset: _transTween.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 27),
                        child: Text(
                          'HUNGRYYY',
                          style: kHeadingStyle,
                        ),
                      ),
                    ),
                    iconTheme: IconThemeData(
                      color: _iconColorTween.value,
                    ),
                    actions: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                        child: IconButton(
                          onPressed: _launchURL,
                          padding: EdgeInsets.all(10),
                          icon: Icon(
                            Icons.phone,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              addedToCartBar,
            ],
          ),
        ),
      ),
    );
  }
}
