import 'package:flutter/material.dart';
import 'package:hungryyy/components/filter_card.dart';
import 'package:hungryyy/components/restaurant_card_big.dart';
import 'package:hungryyy/components/search_box.dart';
import 'package:hungryyy/model/restaurant.dart';
import 'package:hungryyy/screens/cart_screen.dart';
import 'package:hungryyy/utilities/constants.dart';

class AllRestaurantsScreen extends StatefulWidget {
  @override
  _AllRestaurantsScreenState createState() => _AllRestaurantsScreenState();

  final List<Restaurant> restaurants;
  AllRestaurantsScreen({@required this.restaurants});
}

class _AllRestaurantsScreenState extends State<AllRestaurantsScreen> {

  String searchText;
  Map filterMap;
  Widget filterAppliedBar;

  List<Restaurant> filteredRestaurants = [];
  List<Widget> restaurantsToDisplay = [];
  List<Widget> restaurantsToDisplayAll = [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      child: CircularProgressIndicator(
        strokeWidth: 4,
      ),
    ),
  ];

  void loadRestaurants(){
    List<Widget> myList = [];
    for(var restaurant in widget.restaurants){
      myList.add(RestaurantCardBig(restaurant: restaurant));
    }
    setState(() {
      restaurantsToDisplayAll = myList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadRestaurants();
  }

  void showFilterCard() async {
   filterMap = await showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enableDrag: true,
        builder: (BuildContext buildContext){
          return FilterCard();
        });

    print(filterMap);
    if(filterMap != null){
      filteredRestaurants = [];
      for(var restaurant in widget.restaurants){
        if(applyFilter(filterMap,restaurant)){
          filteredRestaurants.add(restaurant);
        }
      }
      setState(() {
        filteredRestaurants = filteredRestaurants;
      });
      List<Widget> myList = [];
      for(var restaurant in filteredRestaurants){
        myList.add(RestaurantCardBig(restaurant: restaurant));
      }
      setState(() {
        restaurantsToDisplayAll = myList;
      });
    }
  }

  bool applyFilter(Map filterMap,Restaurant restaurant) {
    bool pricingFilter,ratingFilter,freeDeliveryFilter,offerFilter;
    pricingFilter = true;
    switch(filterMap['rating']){
      case Rating.low : ratingFilter = restaurant.rating <= 2;
      break;
      case Rating.mid : ratingFilter = restaurant.rating > 2 && restaurant.rating < 4;
      break;
      case Rating.high : ratingFilter = restaurant.rating > 4;
      break;
      default : ratingFilter = true;
    }
    if(filterMap['freeDelivery']){
      freeDeliveryFilter = restaurant.deliveryCharge == 0;
    }else{
      freeDeliveryFilter = true;
    }
    offerFilter = true;

    return (pricingFilter && ratingFilter && freeDeliveryFilter && offerFilter);
  }

  @override
  Widget build(BuildContext context) {

    if(searchText == null){
      restaurantsToDisplay = restaurantsToDisplayAll;
    }
    if(filteredRestaurants.isEmpty){
      filteredRestaurants = widget.restaurants;
    }

    if(filterMap != null){
      filterAppliedBar = Positioned(
        bottom: 0,
        left: 0,
        child: GestureDetector(
          onTap: (){
            setState(() {
              filterMap = null;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
            decoration: BoxDecoration(
              color: kColorRed,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Text(
                'Filter applied. Tap to remove',
                style: kLabelStyle.copyWith(color: Colors.white,fontSize: 18),
              ),
            ),
          ),
        ),
      );
    }else{
      filterAppliedBar = Container();
    }

    return Scaffold(
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
                  onPressed: () {
                    Navigator.pushNamed(context,CartScreen.id);
                  },
                  padding: EdgeInsets.all(10),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: kColorBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
                  child: SearchBox(
                    hint: 'Search Food',
                    onChanged: (value) {
                      if(value.toString().trim().isEmpty){
                        setState(() {
                          searchText = null;
                        });
                      }else{
                        searchText = value.toString().toLowerCase();
                        List<Restaurant> filteredList = filteredRestaurants.where((restaurant) => restaurant.name.toLowerCase().contains(searchText)).toList();
                        List<Widget> myList = [];
                        for(var restaurant in filteredList){
                          myList.add(RestaurantCardBig(restaurant: restaurant));
                        }
                        setState(() {
                          restaurantsToDisplay = myList;
                        });
                      }
                    },
                    onPressed: (){
                      showFilterCard();
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: restaurantsToDisplay,
                    ),
                  ),
                ),
              ],
            ),
            filterAppliedBar,
          ],
        ) ,
    );
  }
}
