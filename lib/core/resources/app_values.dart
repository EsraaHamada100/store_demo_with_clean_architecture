/* we make it responsive by just choose the appropriate height in our device and
 that device the size that we choose over the device height to get the probational*/

import 'dimensions.dart';

class AppValues {
  /* we get this probational by dividing the device height over the container size
  in our case the device height is 844 and the container size we prefer is 220
  so it's 840 / 220 = 3.84 */
  // static double pageView = Dimensions.screenHeight / 2.64;
  // static double pageViewContainer = Dimensions.screenHeight / 3.84;
  // static double pageViewDetailsContainer = Dimensions.screenHeight / 7.03;
  // static EdgeInsetsGeometry appPadding = EdgeInsets.all(AppPadding.p20);

  static double categoryContainerHeight = Dimensions.screenHeight / 3;
}

class AppMargin {
  static double m2 = Dimensions.screenHeight / 422;
  static double m3 = Dimensions.screenHeight / 281.33;
  static double m10 = Dimensions.screenHeight / 84.4;
  static double m20 = Dimensions.screenHeight / 42.2;
  static double m30 = Dimensions.screenHeight / 28.13;
}

class AppPadding {
  static double p5 = Dimensions.screenHeight / 168;
  static double p10 = Dimensions.screenHeight / 84.4;
  static double p15 = Dimensions.screenHeight / 56.27;
  static double p20 = Dimensions.screenHeight / 42.2;
  static double p50 = Dimensions.screenHeight / 16.88;
  static double p120 = Dimensions.screenHeight / 7.03;
}

class AppSize {
  static double s1_2 = Dimensions.screenHeight / 703.33;
  static double s15 = Dimensions.screenHeight / 56.27;
  static double s16 = Dimensions.screenHeight / 52.75;
  static double s24 = Dimensions.screenHeight / 35.17;
  static double s40 = Dimensions.screenHeight / 21.1;
}

class AppHeight {
  static double h1_8 = Dimensions.screenHeight / 468.89;
  static double h10 = Dimensions.screenHeight / 84.4;
  static double h15 = Dimensions.screenHeight / 56.27;
  static double h20 = Dimensions.screenHeight / 42.2;
  static double h30 = Dimensions.screenHeight / 28.13;
  static double h45 = Dimensions.screenHeight / 18.76;
  static double h80 = Dimensions.screenHeight / 10.55;
  static double h100 = Dimensions.screenHeight / 8.44;
  static double h120 = Dimensions.screenHeight / 7.03;
  static double h300 = Dimensions.screenHeight / 2.81;
  static double h350 = Dimensions.screenHeight / 2.41;
  static double h900 = Dimensions.screenHeight / 0.94;
}

class AppWidth {
  static double w5 = Dimensions.screenHeight / 168;
  static double w10 = Dimensions.screenHeight / 84.4;
  static double w20 = Dimensions.screenHeight / 42.2;
  static double w45 = Dimensions.screenHeight / 18.76;
  static double w120 = Dimensions.screenHeight / 7.03;
}

class AppRadius {
  static double r5 = Dimensions.screenHeight / 168;
  static double r15 = Dimensions.screenHeight / 56.27;
  static double r20 = Dimensions.screenHeight / 42.2;
  static double r30 = Dimensions.screenHeight / 28.13;
  static double r40 = Dimensions.screenHeight / 21.1;
}
