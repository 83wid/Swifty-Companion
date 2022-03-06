import 'package:flutter/material.dart';

final theme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  primaryColor: Colors.white,

  // Define the default font family.
  fontFamily: 'Georgia',

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  primaryTextTheme: const TextTheme(
    headline1: TextStyle(fontWeight: FontWeight.bold),
    headline6: TextStyle(fontStyle: FontStyle.italic),
    bodyText2: TextStyle(
      fontFamily: 'Hind',
    ),
    bodyText1: TextStyle(fontFamily: 'Hind', fontWeight: FontWeight.bold),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(fontWeight: FontWeight.bold),
    headline6: TextStyle(fontStyle: FontStyle.italic),
    bodyText1: TextStyle(fontFamily: 'Hind', fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontFamily: 'Hind', fontWeight: FontWeight.bold),
    button: TextStyle(fontFamily: 'Hind'),
  ),
);

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width;
    screenHeight = _mediaQueryData?.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}
