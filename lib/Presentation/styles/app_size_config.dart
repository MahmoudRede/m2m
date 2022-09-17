import 'package:flutter/material.dart';

class SizeConfig extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget? desktop;


  static double width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  static double height = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double bottomPadding = MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.bottom;
  static double topPadding = MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;


  const SizeConfig({
    Key? key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);


  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 700;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 700 && MediaQuery.of(context).size.width <= 1100;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  static bool keyboardIsVisible() => WidgetsBinding.instance.window.viewInsets.bottom> 0.0;



  //#region headline 1 Size
  static double headline1Size = SizeConfig.height * 0.024 ; //26px
//#endregion

  //#region headline 2 Size
  static double headline2Size = SizeConfig.height * 0.021; //20 px
//#endregion

  //#region headline 3 Size
  static double headline3Size = SizeConfig.height * 0.018 ; //18 px
//#endregion

  //#region headline 4 Size
  static double headline4Size = SizeConfig.height * 0.016 ; //16 px
//#endregion

  //#region headline 5 Size
  static double headline5Size = SizeConfig.height * 0.014 ; //14 px
//#endregion

  //#region headline 6 Size
  static double headline6Size = SizeConfig.height * 0.012 ; //12 px
//#endregion

  //#region subtitle 1 Size
  static double subtitle1Size = SizeConfig.height * 0.01 ; //10 px
//#endregion



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      return desktop!;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile!;
    }
  }


}
