import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/bill_item.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/utilities/cart_api.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BillingScreen extends StatefulWidget {
  @override
  _BillingScreenState createState() => _BillingScreenState();

  final Restaurant restaurant;
  BillingScreen({@required this.restaurant});
}

class _BillingScreenState extends State<BillingScreen> {

  CartApi cartApi = CartApi.instance;
  UserApi userApi = UserApi.instance;
  double _totalCost = 0;
  double _totalDiscount = 0;
  double _deliveryCharge = 0;
  double _finalAmount = 0;
  String cartItems = "";
  bool _loading = false;

  void calculateAmount(){
    for(var map in cartApi.cartItems){
      Dish dish = map['product'];
      _totalCost = _totalCost + dish.price;
      _totalDiscount = _totalDiscount + (dish.price)*dish.discount/100 ;
    }
    _finalAmount = _totalCost + _deliveryCharge - _totalDiscount;
  }

  Future<void> placeOrder() async {
    setState(() {
      _loading = true;
    });
    final http.Response response = await http.post(kPlaceOrderUrl,body:{
      'restaurant_id': widget.restaurant.id,
      'restaurant_name': widget.restaurant.name,
      'customer_email' : userApi.email,
      'customer_contact' : (userApi.phoneNumber).toString(),
      'to_lat' : (userApi.latitude).toString(),
      'to_long' : (userApi.longitude).toString(),
      'price' : (_finalAmount).toString(),
      'timestamp' : (DateTime.now().millisecondsSinceEpoch).toString(),
      'cart_items' : cartItems,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == "SUCCESS"){
        setState(() {
          _loading = false;
        });
        await AlertBox.showSuccessBox(context, 'Your order from ${widget.restaurant.name} has been placed successfully', 'Order Placed');
        cartApi.cartItems = [];
        Navigator.pop(context);
      }else{
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context, 'Unable to place order');
      }
    }else{
      // Unable to establish connection
      setState(() {
        _loading = false;
      });
      AlertBox.showErrorBox(context,
          "Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    _deliveryCharge = widget.restaurant.deliveryCharge;
    calculateAmount();
    for(var map in cartApi.cartItems){
      Dish dish = map['product'];
     cartItems = cartItems + dish.name + ',';
    }
    super.initState();
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
                  'Billing Details',
                  style: kHeadingStyle,
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                BillItem(
                  labelText: 'Total Cost',
                  valueText: 'Rs $_totalCost',
                ),
                BillItem(
                  labelText: 'Total Discount',
                  valueText: 'Rs. $_totalDiscount off',
                ),
                BillItem(
                  labelText: 'Delivery Charge',
                  valueText: 'Rs. $_deliveryCharge',
                ),
                SizedBox(
                  height: 15,
                ),
                BillItem(
                  labelText: 'Final Amount',
                  valueText: 'Rs $_finalAmount',
                ),
              ],
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: (){
              // TODO: ADD PAYMENT GATEWAY
              placeOrder();
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
                  'Proceed to pay',
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

