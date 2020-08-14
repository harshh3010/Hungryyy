import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungryyy/screens/navigation_screens/contact_us_screen.dart';
import 'package:hungryyy/screens/navigation_screens/help_screen.dart';
import 'package:hungryyy/screens/navigation_screens/my_orders_screen.dart';
import 'package:hungryyy/screens/navigation_screens/search_page.dart';
import 'package:hungryyy/utilities/constants.dart';
import 'navigation_screens/my_address_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();

  final int currentIndex;
  HomeScreen({@required this.currentIndex});
}

class _HomeScreenState extends State<HomeScreen> {

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double rotationAngle = 0;
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {

    if(isDrawerOpen){
      xOffset = MediaQuery.of(context).size.width * .6;
      yOffset = MediaQuery.of(context).size.height*.33;
      rotationAngle = -20*3.14/180;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    }else{
      xOffset = 0;
      yOffset = 0;
      rotationAngle = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    }

    Widget iconButton = !isDrawerOpen ? IconButton(
      onPressed: (){
        setState(() {
          isDrawerOpen = true;
        });
      },
      padding: EdgeInsets.all(10),
      icon: Icon(
        Icons.restaurant_menu,
        color: kColorBlack,
      ),
    ) : IconButton(
      onPressed: (){
        setState(() {
          isDrawerOpen = false;
        });
      },
      padding: EdgeInsets.all(10),
      icon: Icon(
        Icons.arrow_back_ios,
        color: kColorBlack,
      ),
    );

    List<Widget> displayPages = [
      SearchPage(
        iconButton: iconButton,
      ),
      MyOrdersScreen(
        iconButton: iconButton,
      ),
      MyAddressScreen(
        iconButton: iconButton,
        onAddressChange: (){
          HomeScreen(currentIndex: widget.currentIndex).createState();
        },
      ),
      ContactUsScreen(
        iconButton: iconButton,
      ),
      HelpScreen(
        iconButton: iconButton,
      ),
    ];

    return SafeArea(
      top: false,
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 250),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor)..rotateZ(rotationAngle),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: kColorBlack.withOpacity(0.1),
              offset: Offset(0,3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Material(
          child: IndexedStack(
            index: widget.currentIndex,
            children: displayPages,
          ),
        ),
      ),
    );
  }
}