import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class InvestmentDivider extends StatelessWidget {
  const InvestmentDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width*0.05,
        vertical: SizeConfig.height * 0.01,
      ),
      child: Container(
        height: SizeConfig.height * 0.08,
        child: Row(
          children: [
            Icon(
              Icons.monetization_on_outlined,
              size: SizeConfig.width*0.1,
              color: ColorManager.black,
            ),
            const SizedBox(
              width: 10.0,
            ),
            Text(
              'Start Investment,',
              style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: SizeConfig.headline1Size,
                color: ColorManager.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
