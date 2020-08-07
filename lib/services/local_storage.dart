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

}