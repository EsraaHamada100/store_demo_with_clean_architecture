import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'color_manager.dart';
import 'font_weight_manager.dart';
import 'styles_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: 'Arial',
    // main colors
    primaryColor: ColorManager.mainColor,
    backgroundColor: Colors.white,
    // primaryColorLight: ColorManager.lightPrimary,
    // primaryColorDark: ColorManager.darkPrimary,
    // disabledColor: ColorManager.grey1,
    // splashColor: ColorManager.lightPrimary,

    // // card view theme
    // cardTheme: CardTheme(
    //   color: Colors.white,
    //   shadowColor: ColorManager.grey,
    //   elevation: AppSize.s4,
    // ),

    // // appBar theme
    // appBarTheme: AppBarTheme(
    //   centerTitle: true,
    //   color: ColorManager.primary,
    //   elevation: AppSize.s4,
    //   shadowColor: ColorManager.lightPrimary,
    //   titleTextStyle:
    //       getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white),
    // ),

    // // button theme
    // buttonTheme: ButtonThemeData(
    //   shape: const StadiumBorder(),
    //   disabledColor: ColorManager.grey1,
    //   buttonColor: ColorManager.primary,
    //   splashColor: ColorManager.lightPrimary,
    // ),

    // // elevated button theme
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     textStyle: getRegularStyle(
    //       fontSize: FontSize.s17,
    //       color: ColorManager.white,
    //     ),
    //     backgroundColor: ColorManager.primary,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(AppSize.s12),
    //     ),
    //   ),
    // ),

    // text theme
    textTheme: TextTheme(
      // don't use the styles that has numbers like headline1 , bodyText1..etc
      // because it's duplicated

      displayLarge: getSemiBoldStyle(
        color: ColorManager.secondaryColor,
        fontSize: FontSize.s16,
      ),
      // headlineLarge: getSemiBoldStyle(
      //   color: ColorManager.darkGrey,
      //   fontSize: FontSize.s16,
      // ),
      // headlineMedium: getRegularStyle(
      //   color: ColorManager.darkGrey,
      //   fontSize: FontSize.s14,
      // ),
      titleLarge:
          getMediumStyle(color: ColorManager.secondaryColor, fontSize: 22.sp),
      titleMedium: getMediumStyle(
        color: Colors.black,
        fontSize: 16.sp,
      ),

      titleSmall: getRegularStyle(
        color: Colors.black,
        fontSize: 14.sp,
      ),
      // bodyLarge: getRegularStyle(color: ColorManager.grey1),
      // bodySmall: getRegularStyle(color: ColorManager.grey),
    ),

    // input decoration theme (text form field )
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      
      contentPadding: EdgeInsets.all(1.h),
      prefixIconColor: Colors.black,
      hintStyle: getRegularStyle(
        color: Colors.grey,
        fontSize: 14.sp,
      ),
      // labelStyle: getMediumStyle(
      //   color: Colors.black,
      //   fontSize: 14.sp,
      // ),
      // errorStyle: getRegularStyle(color: ColorManager.error),
      // enabledBorder: OutlineInputBorder(
      //   borderSide: BorderSide(
      //     color: Colors.grey,
      //     width: 15.h,
      //   ),
      //   borderRadius: BorderRadius.all(Radius.circular(1.h)),
      // ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1.0,
          color: Colors.grey,
        ), // BorderSide
      ),

      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(45.0),
      //   borderSide: const BorderSide(
      //     width: 2.0,
      //     color: Colors.green,
      //   ), // BorderSide
      // ), // OutlineInputBorder
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 1.0,
          color: ColorManager.secondaryColor,
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: ColorManager.primary,
        //     width: AppSize.s1_5,
        //   ),
        //   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: ColorManager.error,
        //     width: AppSize.s1_5,
        //   ),
        //   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: ColorManager.primary,
        //     width: AppSize.s1_5,
        //   ),
        //   borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
