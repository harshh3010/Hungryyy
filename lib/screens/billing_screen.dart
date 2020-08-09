import 'package:flutter/material.dart';
import 'package:hungryyy/components/bill_item.dart';
import 'package:hungryyy/model/dish.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/utilities/cart_api.dart';
import 'package:hungryyy/utilities/constants.dart';

class BillingScreen extends StatefulWidget {
  @override
  _BillingScreenState createState() => _BillingScreenState();

  final Restaurant restaurant;
  BillingScreen({@required this.restaurant});
}

class _BillingScreenState extends State<BillingScreen> {

  CartApi cartApi = CartApi.instance;
  double _totalCost = 0;
  double _totalDiscount = 0;
  double _deliveryCharge = 0;
  double _finalAmount = 0;

  void calculateAmount(){
    for(var map in cartApi.cartItems){
      Dish dish = map['product'];
      _totalCost = _totalCost + dish.price;
      _totalDiscount = _totalDiscount + (dish.price)*dish.discount/100 ;
    }
    _finalAmount = _totalCost + _deliveryCharge - _totalDiscount;
  }

  @override
  void initState() {
    _deliveryCharge = widget.restaurant.deliveryCharge;
    calculateAmount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            // TODO:CODE
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
    );
  }
}

