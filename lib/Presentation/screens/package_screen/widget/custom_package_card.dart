import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/details_screen/screen/details_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class CustomPackageCard extends StatelessWidget {
  final String image;
  final String title;
  final String tasksNum;

  const CustomPackageCard({
    Key? key,
    required this.image,
    required this.title,
    required this.tasksNum,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width:  SizeConfig.width * 0.7,
        height:  SizeConfig.height * 0.55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.lightBlue2,
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textManager(
                  color: ColorManager.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailsScreen())),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(
                      SizeConfig.height*0.01,
                    ),
                    child: Text(
                      "More",
                      style: textManager(
                        color: ColorManager.black,
                        fontSize: SizeConfig.headline3Size,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Lottie.asset(image),
              ),
              Text(
                tasksNum,
                style: textManager(
                  color: ColorManager.black,
                  fontSize: SizeConfig.headline2Size,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}