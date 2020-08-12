import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;

const String order_id = 'O100000001';
const String restaurant_id = 'R100000001';
const String name = 'Delivery guy name';
const int phoneNumber = 1234567890;

class OrderTrackHostScreen extends StatefulWidget {
  @override
  _OrderTrackHostScreenState createState() => _OrderTrackHostScreenState();
}

class _OrderTrackHostScreenState extends State<OrderTrackHostScreen> {

  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation,distanceFilter: 10);

  Future<void> updateLocation(Position position) async {
    final http.Response response = await http.post(kHostDeliveryLocationUrl,body: {
      'order_id' : order_id,
      'restaurant_id' : restaurant_id,
      'latitude' : position.latitude.toString(),
      'longitude' : position.longitude.toString(),
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      print('updated location');
    }
  }

  @override
  void initState() {
    super.initState();

    //TODO: ASK TO TURN ON LOCATION FIRST
    geolocator.getPositionStream(locationOptions).listen((Position position) {
      if(position == null){
        print('location not updated');
      }else{
        updateLocation(position);
        print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text(
          'Your location is being tracked',
          style: kHeadingStyle,
        ),
      ),
    );
  }
}
