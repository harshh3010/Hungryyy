import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:hungryyy/components/drawer_item.dart';
import 'package:hungryyy/screens/home_screen.dart';
import 'package:hungryyy/services/local_storage.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'package:hungryyy/utilities/user_api.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'login_screen.dart';

class MenuScreen extends StatefulWidget {

  static final String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  int _currentPageIndex = 0;
  bool _loading = false;
  UserApi userApi = UserApi.instance;

  Future<void> logoutUser() async {
    await LocalStorage.removeLoginInfo();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  Future<void> getLocation() async {
    final query = "${userApi.houseName}, ${userApi.streetName}, ${userApi.cityName}, ${userApi.stateName} ${userApi.postalCode}, ${userApi.countryName}";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("${first.featureName} : ${first.coordinates}");
    userApi.latitude = first.coordinates.latitude;
    userApi.longitude = first.coordinates.longitude;
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Stack(
      children: <Widget>[
        ModalProgressHUD(
          inAsyncCall: _loading,
          color: Colors.white,
          opacity: .5,
          child: Material(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.95),BlendMode.srcATop),
                )
              ),
              height: double.infinity,
              width: double.infinity,
              child: SafeArea(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Text(
                                    userApi.name,
                                    style: kLabelStyle,
                                  ),
                                  Text(
                                    userApi.email,
                                    style: TextStyle(
                                      fontFamily: 'GT Eesti',
                                      color: Colors.grey.shade500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Expanded(
                                child: CustomScrollView(
                                  slivers: <Widget>[
                                    SliverFillRemaining(
                                      hasScrollBody: false,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          DrawerItem(
                                            label: 'Home',
                                            icon: Icons.home,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 0;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'My Orders',
                                            icon: Icons.content_paste,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 1;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'My Address',
                                            icon: Icons.location_on,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 2;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'Contact Us',
                                            icon: Icons.chat_bubble_outline,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 3;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'Help',
                                            icon: Icons.help_outline,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 4;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        DrawerItem(
                          label: 'Log Out',
                          icon: Icons.exit_to_app,
                          onPressed: () async {
                            setState(() {
                              _loading = true;
                            });
                            await logoutUser();
                            setState(() {
                              _loading = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        HomeScreen(
          currentIndex: _currentPageIndex,
        ),
      ],
    );
  }
}
