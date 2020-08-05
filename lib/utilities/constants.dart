import 'package:flutter/material.dart';

const Color kColorYellow = Color(0xffffc700);
const Color kColorRed = Color(0xffff403b);
const Color kColorBlack = Color(0xff000000);
const Color kColorGrey = Color(0xff8d8d8d);

const kHostUrl = 'http://192.168.225.195/hungryyy-app';
const String kRegisterUrl = "$kHostUrl/registration.php";
const String kLoginUrl = "$kHostUrl/login_user.php";
const String kSaveDetailsUrl = "$kHostUrl/save_user_details.php";
const String kCheckUserDetailsUrl = "$kHostUrl/check_user_details.php";

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