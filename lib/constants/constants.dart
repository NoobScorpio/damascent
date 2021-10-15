import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static String appName = "Damascent";
  static TextStyle bigStyle =
      TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600);
  static TextStyle bigStyleAlt =
      TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w600);
  static TextStyle smallStyle =
      TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle smallStyleAlt =
      TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400);
  static TextStyle avgStyleAlt =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle avgStyleAltBold =
      TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600);
  static TextStyle avgStyleBold =
      TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600);
  static TextStyle avgStyle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle priceStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Raleway');
  static TextStyle priceStyleAlt = TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Raleway');
  static Color primaryColor = Color(0xffFF9900);
}

double getHeight(context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(context) {
  return MediaQuery.of(context).size.width;
}

push(context, obj) {
  Navigator.push(context, MaterialPageRoute(builder: (c) => obj));
}

pop(context) {
  Navigator.pop(context);
}
