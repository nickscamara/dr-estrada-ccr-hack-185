import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: Color(0xff2EB872),
  accentColor: Color(0xffffffff),
  secondaryHeaderColor: Color(0xffA3DE83),

  fontFamily: "Avenir"

);
final darkTheme = ThemeData(
  primaryColor: Color(0xffff004d),
  brightness: Brightness.dark,
  backgroundColor:  Color(0xFF212121),
  accentColor:  Color(0xFF212121),
  highlightColor: Colors.white,
  secondaryHeaderColor: Color(0xff9e005d),
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white,
  bottomAppBarColor: Colors.red,
  indicatorColor: Colors.white,
  splashColor: Color(0xfff77a05),
  buttonColor: Color(0xfff77a05),
  selectedRowColor: Colors.purpleAccent,
  textSelectionHandleColor:  const Color(0xFF212121),
);
// final appTheme = ThemeData(
//   primaryColor: Colors.blue[300],
//   brightness: Brightness.dark,
//   backgroundColor: const Color(0xFF212121),
//   accentColor: Colors.white,
//   secondaryHeaderColor: Color(0xff4f6ab2),
//   accentIconTheme: IconThemeData(color: Colors.white),
//   dividerColor: Colors.white,
//   indicatorColor: Colors.white,
//   splashColor: Color(0xfff77a05),
//   buttonColor: Color(0xfff77a05),
//   selectedRowColor: Colors.purpleAccent,
//   textSelectionHandleColor:  const Color(0xFF212121),
//   fontFamily: "Roboto"
// );


// final lightTheme = ThemeData(
//   primaryColor: Colors.blue[300],
//   backgroundColor: Colors.white,
//   accentColor: Colors.black,
//   secondaryHeaderColor: Color(0xff4f6ab2),

//   accentIconTheme: IconThemeData(color: Colors.white),
//   dividerColor: Colors.white,
//   indicatorColor: Colors.white,
//   splashColor: Color(0xfff77a05),
//   buttonColor: Color(0xfff77a05),
//   selectedRowColor: Colors.purpleAccent,
//   textSelectionHandleColor:  const Color(0xFF212121),
//   fontFamily: "Roboto"
// );