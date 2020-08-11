import 'package:flutter/material.dart';
import 'package:hungryyy/model/order.dart';
import 'package:hungryyy/utilities/constants.dart';

class OrderCard extends StatelessWidget {

  final Order order;
  final Function cancelOrder,trackOrder;
  OrderCard({@required this.order,@required this.cancelOrder,@required this.trackOrder});

  List<Widget> getOrderProducts() {
    List<Widget> productList = [];
    for(var productName in order.cartItems){
      productList.add(
        Text(
          productName,
          style: kLabelStyle.copyWith(fontSize: 12,color: Colors.grey.shade500),
        ),
      );
    }
    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: kColorBlack.withOpacity(0.1),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            order.restaurantName,
            style: kLabelStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getOrderProducts(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Rs ${order.price}',
            style: kLabelStyle.copyWith(color: kColorRed),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: cancelOrder,
                  padding: EdgeInsets.all(10),
                  color: kColorYellow,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: trackOrder,
                  padding: EdgeInsets.all(10),
                  color: kColorYellow,
                  child: Text(
                    'Track',
                    style: TextStyle(
                      fontFamily: 'GT Eesti',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}