import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class CourseItemWidget extends StatelessWidget {
  final String title;
  final String image;
  const CourseItemWidget({
    required this.title,
    required this.image,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        width: MediaQuery.of(context).size.width *1,
        height: SizeConfig.height*0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            
            // course image
            Image(
              image: NetworkImage(
                image,
              ),
              width: MediaQuery.of(context).size.width *1,
              height: SizeConfig.height*0.2,
              fit: BoxFit.cover,
            ),
            
            // course name
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10
                ),
                color: ColorManager.black.withOpacity(0.5),
                alignment: Alignment.center,
                height: SizeConfig.height*0.05,
                child: Text(
                  title,
                  style: textManager(
                    color: ColorManager.white,
                    fontSize: SizeConfig.headline2Size,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
