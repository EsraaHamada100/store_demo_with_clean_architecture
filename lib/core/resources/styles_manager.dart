
import 'package:flutter/material.dart';

import 'font_weight_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: FontConstants.fontFamily,
    color: color,
    fontWeight: fontWeight,
  );
}

TextStyle getLightStyle(
    {double fontSize = 0, required Color color}) {
  fontSize = (fontSize != 0)?fontSize:FontSize.s12;
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}
TextStyle getRegularStyle(
    {double fontSize = 0, required Color color}) {
  fontSize = (fontSize != 0)?fontSize:FontSize.s12;
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}
TextStyle getMediumStyle(
    {double fontSize = 0, required Color color}) {
  fontSize = (fontSize != 0)?fontSize:FontSize.s12;
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}
TextStyle getSemiBoldStyle(
    {double fontSize = 0, required Color color}) {
  fontSize = (fontSize != 0)?fontSize:FontSize.s12;
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}
TextStyle getBoldStyle(
    {double fontSize = 0, required Color color}) {
  fontSize = (fontSize != 0)?fontSize:FontSize.s12;
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}
