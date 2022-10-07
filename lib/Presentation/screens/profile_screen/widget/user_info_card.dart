import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class UserInfoTask extends StatelessWidget {
  const UserInfoTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: SizeConfig.height*0.2,
      width: SizeConfig.width*0.8,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: SizeConfig.height*0.15,
            width: SizeConfig.width*0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.secondDarkColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.height*0.05,
                ),
                Text(
                  'Mohamed Mmdouh',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.headline2Size,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height*0.0012,
                ),
                Text(
                  'mmdouh1112@gmail.com',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height*0.0012,
                ),
                Text(
                  '+201123780390',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: SizeConfig.height*0.1,
                  width: SizeConfig.height*0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: ColorManager.white,
                  ),
                ),
                Container(
                  height: SizeConfig.height*0.097,
                  width: SizeConfig.height*0.097,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    color: ColorManager.white,
                  ),
                  child: const Image(
                    image: AssetImage(AssetsManager.userImage),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
