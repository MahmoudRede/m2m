import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class PackageDivider extends StatelessWidget {
  const PackageDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.height*0.05,
      ),
      child: Row(
        children: [
          Image(
            image: const AssetImage(AssetsManager.dollarImage),
            height: SizeConfig.height*0.04,
            width: SizeConfig.height*0.04,
          ),
          SizedBox(
            width: SizeConfig.height*0.01,
          ),
          Text(
            'Your Packages',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.headline1Size,
              color: ColorManager.black,
            ),
          ),
        ],
      ),
    );
  }
}
