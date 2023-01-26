import 'package:flutter/material.dart';

import 'dimensions.dart';

class FontConstants {
  static const fontFamily = "Roboto";
}

class FontWeightManager {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
// we use 844 as our phone height som we divide by it
class FontSize {
  // static const double s12 = 12.0;
  // static const double s14 = 14.0;
  // static const double s16 = 16.0;
  // static const double s17 = 17.0;
  // static const double s18 = 18.0;
  static double s12 = Dimensions.screenHeight/70.33;
  static double s16 = Dimensions.screenHeight/ 52.75;
  static double s20 = Dimensions.screenHeight/ 42.2;
  static double s22 = Dimensions.screenHeight/ 38.36;
  static double s26 = Dimensions.screenHeight/ 32.46;
  // static const double s22 = 22.0;
}
