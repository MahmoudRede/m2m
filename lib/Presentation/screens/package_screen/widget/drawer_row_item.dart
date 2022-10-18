import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class DrawerRowItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DrawerRowItem({
    required this.title,
    required this.icon,
    required this.onTap,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:  SizeConfig.height*0.03,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: ColorManager.black,
            ),
            SizedBox(
              width: SizeConfig.height*0.015,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: ColorManager.black,
                  fontSize: SizeConfig.headline2Size,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
