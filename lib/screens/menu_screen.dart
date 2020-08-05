import 'package:flutter/material.dart';
import 'package:hungryyy/components/drawer_item.dart';
import 'package:hungryyy/screens/home_screen.dart';
import 'package:hungryyy/services/local_storage.dart';
import 'package:hungryyy/utilities/constants.dart';
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

  Future<void> logoutUser() async {
    await LocalStorage.removeLoginInfo();
    await LocalStorage.removeUserDetails();
    Navigator.pushReplacementNamed(context, LoginScreen.id);
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
              color: Colors.white,
              height: double.infinity,
              width: double.infinity,
              child: SafeArea(
                child: Container(
                  color: Colors.white,
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
                                    'Harsh Gyanchandani',
                                    style: kLabelStyle,
                                  ),
                                  Text(
                                    'harsh.gyanchandani@gmail.com',
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
                                            label: 'Payment Methods',
                                            icon: Icons.payment,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 3;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'My Vouchers',
                                            icon: Icons.description,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 4;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'Contact Us',
                                            icon: Icons.chat_bubble_outline,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 5;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'Settings',
                                            icon: Icons.settings,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 6;
                                              });
                                            },
                                          ),
                                          DrawerItem(
                                            label: 'Help & FAQs',
                                            icon: Icons.help_outline,
                                            onPressed: (){
                                              setState(() {
                                                _currentPageIndex = 7;
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
