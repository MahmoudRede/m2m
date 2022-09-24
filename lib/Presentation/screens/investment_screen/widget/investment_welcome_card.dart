import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class InvestmentWelcomeCard extends StatelessWidget {
  const InvestmentWelcomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width*0.05,
        vertical: SizeConfig.height * 0.01,
      ),
      child: Container(
        height: SizeConfig.height * 0.19,
        width: SizeConfig.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: ColorManager.secondDarkColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Lottie.asset(AssetsManager.warningImage),
                    SizedBox(
                      width: SizeConfig.width *0.03,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Have a nice day!',
                            textAlign: TextAlign.left,
                            style:  TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                              color: ColorManager.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Start Investment and get fast income with highest profit now,'
                                '\n10% profit for each months, Up to time 6 months, After that total capital will return to the user.',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorManager.lightGrey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
