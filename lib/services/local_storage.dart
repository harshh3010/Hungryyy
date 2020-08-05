import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{

  static Future<void> saveLoginInfo({@required String statusCode,@required String email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_status', statusCode);
    await prefs.setString('login_email', email);
  }

  static Future<void> removeLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login_status', null);
    await prefs.setString('login_email', null);
  }

  static Future<void> saveUserDetails({@required String name,@required String contactNumber,@required String houseName,@required String streetName,
  @required String cityName,@required String stateName,@required String postalCode,@required String countryName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_contact', contactNumber);
    await prefs.setString('house_name', houseName);
    await prefs.setString('street_name', streetName);
    await prefs.setString('city_name', cityName);
    await prefs.setString('state_name', stateName);
    await prefs.setString('postal_code', postalCode);
    await prefs.setString('country_name', countryName);
  }

  static Future<void> removeUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', null);
    await prefs.setString('user_contact', null);
    await prefs.setString('house_name', null);
    await prefs.setString('street_name', null);
    await prefs.setString('city_name', null);
    await prefs.setString('state_name', null);
    await prefs.setString('postal_code', null);
    await prefs.setString('country_name', null);
  }

}