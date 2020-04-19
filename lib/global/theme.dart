import 'package:flutter/material.dart';

Color color1 = Colors.indigo;
Color color2 = Colors.red[600];
Color color3 = Colors.pink[700];
Color color4 = Colors.orange[700];
Color color5 = Colors.cyan[700];

ThemeData lightThemee = ThemeData(
  fontFamily: 'lotus',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Color(0xFF2F006D),
  accentColor: Color(0xFFB33131),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(color: Colors.transparent, elevation: 0,),
  textTheme: TextTheme(
    headline3: TextStyle(color: Colors.black),
    headline5: TextStyle(color: Colors.black),
    headline6: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: Colors.black),
    button: TextStyle(color: Colors.white),
  ),
);

ThemeData darkThemee = ThemeData(
  fontFamily: 'lotus',
  visualDensity: VisualDensity.adaptivePlatformDensity,
  primaryColor: Color(0xFF2F006D),
  accentColor: Color(0xFFB33131),
  scaffoldBackgroundColor: Color(0xFF0B0014),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
  ),
  indicatorColor: Colors.orange[700],
  textTheme: TextTheme(
    headline3: TextStyle(color: Colors.white),
    headline5: TextStyle(color: Colors.white),
    headline6: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: Colors.white),
    button: TextStyle(color: Colors.white),
  ),
);
