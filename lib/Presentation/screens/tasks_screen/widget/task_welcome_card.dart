import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TaskWelcomeCard extends StatelessWidget {
  const TaskWelcomeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
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
                    Lottie.asset(AssetsManager.helloImage),
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
                            'Start perform out your tasks right now.',
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
              LinearPercentIndicator(
                width: SizeConfig.width * 0.85,
                animation: true,
                lineHeight: 5.0,
                animationDuration: 2000,
                percent: 0.9,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: ColorManager.lightBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
