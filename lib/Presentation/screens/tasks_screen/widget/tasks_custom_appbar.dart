import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class TasksCustomAppbar extends StatelessWidget {
  const TasksCustomAppbar({
    // required this.title,
    // required this.userImage,
    Key? key}) : super(key: key);

  // final String title;
  // final String userImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.topPadding,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: SizeConfig.height*0.01,
            vertical: SizeConfig.height*0.01,
          ),
          child: Row(
            children: [
              IconButton(
                  onPressed: ()=> Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: ColorManager.black,
                  ),
              ),
              SizedBox(
                width: SizeConfig.height*0.01,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorManager.lightGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Mohamed Mmdouh',
                      textAlign: TextAlign.left,
                      style:  TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: SizeConfig.width *0.08,
                backgroundImage: const AssetImage(
                  AssetsManager.userImage,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
