import 'package:flutter/material.dart';
import 'package:hungryyy/components/drawer_item.dart';
import 'file:///F:/FlutterProjects/hungryyy/hungryyy/lib/screens/navigation_screens/home_screen.dart';
import 'package:hungryyy/utilities/constants.dart';

class MenuScreen extends StatefulWidget {

  static final String id = 'menu_screen';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  Widget displayPage;
  String displayPageId = 'home_page';

  @override
  Widget build(BuildContext context) {

    switch(displayPageId){
      case 'home_page': displayPage = HomeScreen();
      break;
    }

    return Stack(
      children: <Widget>[
        Material(
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
                      Column(
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
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                DrawerItem(
                                  label: 'Home',
                                  icon: Icons.home,
                                  onPressed: (){
                                    setState(() {
                                      displayPageId = 'home_page';
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'My Orders',
                                  icon: Icons.content_paste,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'My Profile',
                                  icon: Icons.person_outline,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'My Address',
                                  icon: Icons.location_on,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'Payment Methods',
                                  icon: Icons.payment,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'My Vouchers',
                                  icon: Icons.description,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'Contact Us',
                                  icon: Icons.chat_bubble_outline,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'Settings',
                                  icon: Icons.settings,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                DrawerItem(
                                  label: 'Help & FAQs',
                                  icon: Icons.help_outline,
                                  onPressed: (){
                                    //TODO:CODE
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DrawerItem(
                        label: 'Log Out',
                        icon: Icons.exit_to_app,
                        onPressed: (){
                          //TODO:CODE
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        displayPage,
      ],
    );
  }
}
