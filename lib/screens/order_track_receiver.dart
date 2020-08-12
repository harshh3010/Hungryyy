import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hungryyy/components/alert_box.dart';
import 'package:hungryyy/model/order.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

const double CAMERA_ZOOM = 14;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;

class OrderTrackReceiverScreen extends StatefulWidget {
  @override
  _OrderTrackReceiverScreenState createState() =>
      _OrderTrackReceiverScreenState();

  final Order order;
  OrderTrackReceiverScreen({@required this.order,});
}

class _OrderTrackReceiverScreenState extends State<OrderTrackReceiverScreen> {

  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle;
  GoogleMapController mapController;
  LatLng FOOD_LOCATION,SOURCE_LOCATION ,DEST_LOCATION;
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyDO3Ufdxe2fOSn0cwkuRsAMDqiscLxXXVU";
  UserApi userApi = UserApi.instance;
  bool _loading = true;
  var cameraPositionLatLng;
  double distance = 0;

  Future<void> receiveLocation() async {
    final http.Response response = await http.post(kReceiveDeliveryLocationUrl,body: {
      'order_id' : widget.order.id,
      'restaurant_id' : widget.order.restaurantId,
    });
    if(response.statusCode == 200 || response.statusCode == 201){
      var data = jsonDecode(response.body.toString());
      if(data.toString() == 'Error loading data'){
        AlertBox.showErrorBox(context, "Sorry, we are unable to fetch your food's location 😔");
        setState(() {
          _loading = false;
        });
      }else{
        FOOD_LOCATION = LatLng(double.parse(data[0]['d_lat']),double.parse(data[0]['d_lon']));
        SOURCE_LOCATION = LatLng(double.parse(data[0]['r_lat']),double.parse(data[0]['r_lon']));
        distance = await Geolocator().distanceBetween(FOOD_LOCATION.latitude, FOOD_LOCATION.longitude, DEST_LOCATION.latitude,DEST_LOCATION.longitude);
        setState(() {
          FOOD_LOCATION = FOOD_LOCATION;
          SOURCE_LOCATION = SOURCE_LOCATION;
          distance = distance;
          _loading = false;
        });
      }
    }else{
      AlertBox.showErrorBox(context, "Unable to establish connection with the servers.\nERROR CODE: ${response.statusCode}");
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    FOOD_LOCATION = LatLng(userApi.latitude,userApi.longitude);
    SOURCE_LOCATION = LatLng(userApi.latitude,userApi.longitude);
    DEST_LOCATION = LatLng(userApi.latitude,userApi.longitude);
    cameraPositionLatLng = DEST_LOCATION;
    receiveLocation();
  }

  @override
  Widget build(BuildContext context) {

    CameraPosition initialLocation = CameraPosition(
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TILT,
      target: cameraPositionLatLng,
    );

    void setMapPins() {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: BitmapDescriptor.defaultMarkerWithHue(50),
        ));
        _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: BitmapDescriptor.defaultMarker,
        ));
        _markers.add(Marker(
          markerId: MarkerId('foodPin'),
          position: FOOD_LOCATION,
          icon: BitmapDescriptor.defaultMarkerWithHue(50),
        ));
      });
    }

    setPolylines() async {
      List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(googleAPIKey,
          SOURCE_LOCATION.latitude,SOURCE_LOCATION.longitude, DEST_LOCATION.latitude, DEST_LOCATION.longitude);
      if(result.isNotEmpty){
        result.forEach((PointLatLng point){
          polylineCoordinates.add(
              LatLng(point.latitude, point.longitude));
        });
      }
      setState(() {
        Polyline polyline = Polyline(
            polylineId: PolylineId('poly'),
            color: kColorRed,
            points: polylineCoordinates
        );
        _polylines.add(polyline);
      });
    }

    void onMapCreated(GoogleMapController controller) {
      _controller.complete(controller);
      mapController = controller;
      mapController.setMapStyle(_mapStyle);
      setMapPins();
      setPolylines();
    }

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
                onPressed: () async {
                  final GoogleMapController controller = await _controller.future;
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      zoom: CAMERA_ZOOM,
                      bearing: CAMERA_BEARING,
                      tilt: CAMERA_TILT,
                      target: FOOD_LOCATION,
                    )
                  ));
                },
                padding: EdgeInsets.all(10),
                icon: Icon(
                  Icons.fastfood,
                  color: kColorBlack,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        opacity: 0,
        child: GoogleMap(
          myLocationEnabled: false,
          compassEnabled: false,
            tiltGesturesEnabled: false,
            markers: _markers,
            polylines: _polylines,
            mapType: MapType.normal,
            initialCameraPosition: initialLocation,
            onMapCreated: onMapCreated
        ),
      ),
      bottomNavigationBar: IgnorePointer(
        ignoring: true,
        child: Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.white.withOpacity(1), Colors.white.withOpacity(0)])
          ),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Your food is on its way',
                style: kHeadingStyle,
              ),
              Text(
                distance != 0 ? ((distance/1000).floor() > 0 ? 'Just ${(distance/1000).floor()} km away...' : 'Just ${distance.floor()} m away...') : 'Calculating distance...',
                style: kLabelStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}