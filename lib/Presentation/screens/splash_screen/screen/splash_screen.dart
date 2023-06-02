import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/screen/on_boarding_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 6),(){

      if(uId == null){
        return navigateTo(context,OnBoarding());
      }else{
        return navigateTo(context,const PackageScreen());

      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: ColorManager.white ,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white
        ),
      ),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
               Lottie.asset(
                    height: MediaQuery.of(context).size.height*.28,
                    width: MediaQuery.of(context).size.width*1,
                   AssetsManager.testSplash,
               )
          ],
        ),
      ),

    );
  }
}