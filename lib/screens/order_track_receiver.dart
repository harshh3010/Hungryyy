import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(23.6871386, -77.2143403);

class OrderTrackReceiverScreen extends StatefulWidget {
  @override
  _OrderTrackReceiverScreenState createState() =>
      _OrderTrackReceiverScreenState();
}

class _OrderTrackReceiverScreenState extends State<OrderTrackReceiverScreen> {

  Completer<GoogleMapController> _controller = Completer();
  String _mapStyle;
  GoogleMapController mapController;

  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = Set();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "AIzaSyDO3Ufdxe2fOSn0cwkuRsAMDqiscLxXXVU";

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }


  @override
  Widget build(BuildContext context) {

    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION
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
        ),
      ),
      body: GoogleMap(
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialLocation,
          onMapCreated: onMapCreated
      ),
      bottomNavigationBar: IgnorePointer(
        ignoring: true,
        child: Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.white.withOpacity(.75), Colors.white.withOpacity(0)])
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
                '30 min',
                style: kLabelStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}