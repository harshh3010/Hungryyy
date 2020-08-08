import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/dish_item.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/utilities/constants.dart';

class RestaurantScreen extends StatefulWidget {
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();

  final Restaurant restaurant;
  RestaurantScreen({@required this.restaurant});
}

class _RestaurantScreenState extends State<RestaurantScreen> with TickerProviderStateMixin {

  AnimationController _ColorAnimationController;
  AnimationController _TextAnimationController;
  Animation _colorTween, _iconColorTween;
  Animation<Offset> _transTween;

  @override
  void initState() {
    _ColorAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_ColorAnimationController);
    _iconColorTween = ColorTween(begin: Colors.white, end: kColorBlack)
        .animate(_ColorAnimationController);


    _TextAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));

    _transTween = Tween(begin: Offset(-10, 40), end: Offset(-10, 0))
        .animate(_TextAnimationController);

    super.initState();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _ColorAnimationController.animateTo(scrollInfo.metrics.pixels / 180);

      _TextAnimationController.animateTo(
          (scrollInfo.metrics.pixels - 180) / 50);
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Container(
          height: double.infinity,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(30, 200, 30, 50),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.restaurant.imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(kColorBlack.withOpacity(0.3), BlendMode.srcATop),
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
                            style: kHeadingStyle.copyWith(color: Colors.white,fontSize: 30),
                          ),
                          Text(
                            '${widget.restaurant.streetName}, ${widget.restaurant.cityName}',
                            style: kLabelStyle.copyWith(color: Colors.white,fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'North Indian',
                            style: kLabelStyle.copyWith(fontSize: 16),
                          ),
                          DishItem(
                            name: 'Masala Dosa',
                            price: 150,
                          ),
                          DishItem(
                            name: 'Masala Dosa',
                            price: 150,
                          ),
                          DishItem(
                            name: 'Masala Dosa',
                            price: 150,
                          ),
                          DishItem(
                            name: 'Masala Dosa',
                            price: 150,
                          ),
                          DishItem(
                            name: 'Masala Dosa',
                            price: 150,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: AnimatedBuilder(
                  animation: _ColorAnimationController,
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
                          onPressed: () {
                            //TODO:CODE
                          },
                          padding: EdgeInsets.all(10),
                          icon: Icon(
                            Icons.shopping_cart,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}