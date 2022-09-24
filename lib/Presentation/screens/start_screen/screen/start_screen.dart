import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/investment_screen/screen/investment_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/screens/start_screen/widget/startScreenCard.dart';
import 'package:m2m/Presentation/screens/start_screen/widget/start_screen_custom_title.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.height,
        width: SizeConfig.width,
        color: ColorManager.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width *0.05,
          ),
          child: Column(
            children: [
              const StartScreenCustomTitle(),
              SizedBox(
                height: SizeConfig.height*0.1,
              ),
              Lottie.asset(AssetsManager.welcomeImage),
              SizedBox(
                height: SizeConfig.height*0.05,
              ),
              StartScreenCard(
                text: 'package',
                color: ColorManager.black,
                onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> const PackageScreen())),
              ),
              SizedBox(
                height: SizeConfig.height*0.02,
              ),
              StartScreenCard(
                text: 'Investment',
                color: ColorManager.lightBlue,
                onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> const InvestmentScreen())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
