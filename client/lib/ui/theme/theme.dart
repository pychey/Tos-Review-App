import 'package:flutter/material.dart';

///
/// Definition of App colors.
///
class TosReviewColors {
  static Color primaryColor            = const Color(0xFF1B5C58);
  static Color gradientLightColor      = const Color(0xFF69AEA9);
  static Color gradientDarkColor       = const Color(0xFF3F8782);
  static Color greyLightColor     = const Color(0xFFF6F6F6);
  static Color greyDarkColor     = const Color(0xFF6E6868);
  static Color whiteColor    = Colors.white;

  static Color get primary { 
    return TosReviewColors.primaryColor;
  }

  static List<Color> get gradientButton { 
    return [
      TosReviewColors.gradientLightColor,
      TosReviewColors.gradientDarkColor
    ];
  }

  static Color get gradientLight {
    return TosReviewColors.gradientLightColor;
  }

  static Color get gradientDark{
    return TosReviewColors.gradientDarkColor;
  }

  static Color get greyLight {
    return TosReviewColors.greyLightColor;
  }

  static Color get greyDark {
    return TosReviewColors.greyDarkColor;
  }

  static Color get white {
    return TosReviewColors.whiteColor;
  }

}
  
///
/// Definition of App text styles.
///
class TosReviewTextStyles {
  static TextStyle heading = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle titleBold = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle title = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
  static TextStyle label =  TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle labelBold =  TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static TextStyle small =  TextStyle(fontSize: 10, fontWeight: FontWeight.w400);

  static TextStyle body =  TextStyle(fontSize: 13, fontWeight: FontWeight.w400);

  static TextStyle button =  TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
}



///
/// Definition of App spacings, in pixels.
/// Bascially small (S), medium (m), large (l), extra large (x), extra extra large (xxl)
///
class TosReviewSpacings {
  static const double s = 12;
  static const double m = 16; 
  static const double l = 24; 
  static const double xl = 32; 
  static const double xxl = 40; 

  static const double radius = 16; 
  static const double radiusLarge = 40; 
  static const double paddingScreen = 20; 
  static const double paddingLarge = 40; 
}



///
/// Definition of App Theme.
///
ThemeData appTheme =  ThemeData(
  fontFamily: 'Montserrat',
  // scaffoldBackgroundColor: Colors.white,
);
 