import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
    primaryColor: MyBlue.picton,
    accentColor: MyBlue.seagull,
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      display1: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 24,
      ),
      title: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 20.0,
      ),
      body1: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.0,
      ),
      body2: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      headline: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      subhead: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16.0,
      ),
      subtitle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.0,
        color: Colors.grey[500]
      ),
      button: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14.0,
      ),
      caption: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 12.0,
      ),

    ),
  );
}

class MyBlue {
  static final Color polar = Color(0xFFF3FAFD);
  static final Color mintTulip = Color(0xFFC9E9F6);
  static final Color seagull = Color(0xFF87CEEB);
  static final Color picton = Color(0xFF45B3E0);
  static final Color light = Color(0xFF21BEDE);
}

class MyPadding {
  static final double top = 10.0;
  static final double bottom = 10.0;
  static final double right = 10.0;
  static final double left = 10.0;
  static final double all = 10.0;
}

