import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/components/order_card.dart';
import 'package:hungryyy/model/order.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../order_track_receiver.dart';

class MyOrdersScreen extends StatefulWidget {
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();

  final Widget iconButton;
  MyOrdersScreen({@required this.iconButton});
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {

  UserApi userApi = UserApi.instance;
  List<Widget> incompleteOrdersToDisplay = [
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
  List<Widget> completeOrdersToDisplay = [
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
  bool _loading = false;

  Future<void> cancelOrder(String title,Order order) async {
    AlertBox.showConfirmationBox(context,title,() async {
      setState(() {
        _loading = true;
      });
      final http.Response response = await http.post(kRemoveOrderUrl,body: {
        'restaurant_id' : order.restaurantId,
        'id' : order.id,
      });
      if(response.statusCode == 200 || response.statusCode == 201){
        // Connection established
        var data = jsonDecode(response.body.toString());
        if(data.toString() == "SUCCESS"){
          setState(() {
            _loading = false;
          });
          AlertBox.showSuccessBox(context, 'Order removed successfully', 'Success');
          // TODO:Refresh List
        }else {
          setState(() {
            _loading = false;
          });
          AlertBox.showErrorBox(context,'Cannot perform this action');
        }
      }else{
        // Unable to establish connection
        setState(() {
          _loading = false;
        });
        AlertBox.showErrorBox(context,'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
      }
    });
  }

  Future<void> loadUserOrders() async {
    final http.Response response = await http.post(kGetOrdersUrl,body: {
      'customer_email' : userApi.email,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      // Connection established
      var data = jsonDecode(response.body.toString());
      if(data.toString() == "Error loading data"){
        AlertBox.showErrorBox(context, 'We are unable to fetch your orders');
      }else{
        List<Order> completeList = [];
        List<Order> incompleteList = [];
        for(var map in data){
          Order order = Order(
            id: map['id'],
            restaurantId: map['restaurant_id'],
            restaurantName: map['restaurant_name'],
            price: double.parse(map['price']),
            customerEmail: map['customer_email'],
            cartItems: map['cart_items'].toString().split(",").toList(),
            customerContact: map['customer_contact'],
            customerName: map['name'],
            fromLat: double.parse(map['latitude']),
            fromLong: double.parse(map['longitude']),
            timestamp: map['timestamp'],
            toLat: double.parse(map['to_lat']),
            toLong: double.parse(map['to_long']),
            status: map['status'],
          );
          if(order.status == "delivered"){
            completeList.add(order);
          }else{
            incompleteList.add(order);
          }
        }
        completeList.sort((b,a) => a.timestamp.compareTo(b.timestamp));
        incompleteList.sort((b,a) => a.timestamp.compareTo(b.timestamp));

        List<Widget> myList1 = [], myList2 = [];
        for(Order order in completeList){
          myList1.add(
            OrderCard(
              order: order,
              cancelOrder: (){
                cancelOrder('Remove Order History', order);
              },
              trackOrder: (){},
            ),
          );
        }
        for(Order order in incompleteList){
          myList2.add(
            OrderCard(
              order: order,
              cancelOrder: (){
                cancelOrder('Cancel Order', order);
              },
              trackOrder: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTrackReceiverScreen(order: order,)));
              },
            ),
          );
        }
        setState(() {
          incompleteOrdersToDisplay = myList2;
          completeOrdersToDisplay = myList1;
        });
      }
    }else{
      // Unable to establish connection
      AlertBox.showErrorBox(context,'Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    loadUserOrders();
    super.initState();
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
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.only(top: 27),
              child: Text(
                'My Orders',
                style: kHeadingStyle,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: incompleteOrdersToDisplay,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Text(
                  'Previous Orders',
                  style: kLabelStyle,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: completeOrdersToDisplay,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


