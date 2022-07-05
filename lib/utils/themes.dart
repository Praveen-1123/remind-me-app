import 'package:flutter/material.dart';

class Themes {
  final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.grey.shade300,
    focusColor: Colors.black,
    brightness: Brightness.light,
    backgroundColor: Colors.white70,
    scaffoldBackgroundColor: Colors.white,
    shadowColor: Colors.grey.shade200,
    cardColor: Colors.grey.shade200,
    buttonTheme: ButtonThemeData(buttonColor: Colors.black),
    splashColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
      ),
      headline2: TextStyle(
        color: Colors.white,
      ),
      bodyText1: TextStyle(
        color: Colors.grey.shade500,
      ),
    ),
    fontFamily: "Poppins",
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey.shade300,
    focusColor: Colors.white,
    brightness: Brightness.dark,
    backgroundColor: Colors.black54,
    scaffoldBackgroundColor: Colors.black,
    shadowColor: Colors.black54,
    cardColor: Color(0XFF18191b),
    buttonTheme: ButtonThemeData(buttonColor: Colors.white),
    splashColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
      ),
      headline2: TextStyle(
        color: Colors.black,
      ),
      bodyText1: TextStyle(
        color: Colors.grey.shade500,
      ),
    ),
    fontFamily: "Poppins",
  );
}
