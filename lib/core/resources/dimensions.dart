// we used (get) to get the dimensions because if you don't use it you can get
// the dimensions with media query unless you are in a stateful widget



import 'package:flutter/material.dart';


final Size screenSize = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
// final double width = screenSize.width;
// final double height = screenSize.height;
class Dimensions{
  static double screenHeight = screenSize.height;
  static double screenWidth = screenSize.width;
}