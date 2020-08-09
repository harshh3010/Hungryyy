import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/utilities/cart_api.dart';
import 'package:hungryyy/utilities/constants.dart';

class DishItem extends StatefulWidget {
  @override
  _DishItemState createState() => _DishItemState();

  final Dish dish;
  final Function onDishAdded,onDishRemoved;
  DishItem({@required this.dish,@required this.onDishAdded,@required this.onDishRemoved});
}

class _DishItemState extends State<DishItem> {

  int dishCount = 0;
  CartApi cartApi = CartApi.instance;

  @override
  void initState() {
    super.initState();
    for(var map in cartApi.cartItems){
      if(map['product_id'] == widget.dish.id && map['restaurant_id'] == widget.dish.restaurantId){
        setState(() {
          dishCount++;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.dish.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all((Radius.circular(10))),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  widget.dish.name,
                  style: kLabelStyle.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rs ${widget.dish.price}',
                  style: kLabelStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          dishCount == 0 ?
          FlatButton(
            onPressed: (){
              bool sameRestaurant = true;
              for(var map in cartApi.cartItems){
                if(map['restaurant_id'] != widget.dish.restaurantId){
                  sameRestaurant = false;
                }
              }
              if(sameRestaurant){
                setState(() {
                  dishCount = 1;
                });
                cartApi.cartItems.add(
                    {
                      'product_id' : widget.dish.id,
                      'restaurant_id' : widget.dish.restaurantId,
                      'product' : widget.dish,
                    }
                );
                widget.onDishAdded();
              }else{
                AlertBox.showErrorBox(context, 'Cannot add items from two different restaurants');
              }
            },
            child: Text(
              'Add',
              style: kItemStyle.copyWith(color: kColorRed,fontSize: 12),
            ),
          ) :
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(0 <= dishCount){
                        dishCount--;
                        for(var map in cartApi.cartItems){
                          if(map['product_id'] == widget.dish.id && map['restaurant_id'] == widget.dish.restaurantId){
                              cartApi.cartItems.remove(map);
                              break;
                          }
                        }
                        if(dishCount == 0){
                          widget.onDishRemoved();
                        }
                      }
                    });
                  },
                  child: Icon(
                    Icons.remove,
                    color: kColorRed,
                    size: 12,
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  '$dishCount',
                  style: kItemStyle.copyWith(color: kColorRed,fontSize: 12),
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      if(dishCount < 10){
                        dishCount++;
                        bool sameRestaurant = true;
                        for(var map in cartApi.cartItems){
                          if(map['restaurant_id'] != widget.dish.restaurantId){
                            sameRestaurant = false;
                          }
                        }
                        if(sameRestaurant){
                          cartApi.cartItems.add(
                              {
                                'product_id' : widget.dish.id,
                                'restaurant_id' : widget.dish.restaurantId,
                                'product' : widget.dish,
                              }
                          );
                          widget.onDishAdded();
                        }else{
                          AlertBox.showErrorBox(context, 'Cannot add items from two different restaurants');
                        }
                      }
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: kColorRed,
                    size: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
