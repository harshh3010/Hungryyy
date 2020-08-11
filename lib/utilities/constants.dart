import 'package:flutter/material.dart';
import 'package:hungryyy/model/category.dart';

const Color kColorYellow = Color(0xffffc700);
const Color kColorRed = Color(0xffff403b);
const Color kColorBlack = Color(0xff000000);
const Color kColorGrey = Color(0xff8d8d8d);

const kHostUrl = 'http://192.168.43.50/hungryyy-app';
const String kRegisterUrl = "$kHostUrl/registration.php";
const String kLoginUrl = "$kHostUrl/login_user.php";
const String kSaveDetailsUrl = "$kHostUrl/save_user_details.php";
const String kLoadUserDetailsUrl = "$kHostUrl/load_user_details.php";
const String kCheckUserDetailsUrl = "$kHostUrl/check_user_details.php";
const String kLoadCategoriesUrl = "$kHostUrl/load_categories.php";
const String kLoadDishesUrl = "$kHostUrl/load_dishes.php";
const String kLoadRestaurantsUrl = "$kHostUrl/load_restaurants.php";
const String kMostPopularDishUrl = "$kHostUrl/load_most_popular.php";
const String kLoadRestaurantMenuUrl = "$kHostUrl/load_restaurant_menu.php";
const String kOpenRestaurantUrl = "$kHostUrl/load_dish_restaurant.php";
const String kPlaceOrderUrl = "$kHostUrl/place_order.php";
const String kGetOrdersUrl = "$kHostUrl/get_orders.php";

const TextStyle kHeadingStyle = TextStyle(
  fontFamily: 'GT Eesti',
  color: kColorBlack,
  fontSize: 24,
  fontWeight: FontWeight.w600,
);
const TextStyle kLabelStyle = TextStyle(
  fontFamily: 'GT Eesti',
  color: kColorBlack,
  fontSize: 24,
);
const TextStyle kItemStyle = TextStyle(
  fontFamily: 'GT Eesti',
  color: kColorBlack,
  fontSize: 20,
);

const List<Category> kCommonCategories = [
  Category(id: 'category_pizza',name: 'Pizza'),
  Category(id: 'category_burger',name: 'Burger'),
  Category(id: 'category_chinese',name: 'Chinese'),
  Category(id: 'category_dessert',name: 'Desserts'),
  Category(id: 'category_fries',name: 'Fries'),
  Category(id: 'category_shake',name: 'Shakes'),
];