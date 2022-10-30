import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class DrawerRowItem extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const DrawerRowItem({
    required this.title,
    required this.image,
    required this.onTap,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:  SizeConfig.height*0.02,
        ),
        child: Container(
          height: SizeConfig.height*0.06,
          decoration: BoxDecoration(
            color: ColorManager.whiteDark,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              SizeConfig.height*0.01
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(image),
                  height: SizeConfig.height*0.038,
                  width: SizeConfig.height*0.038,
                ),
                SizedBox(
                  width: SizeConfig.height*0.018,
                ),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                      color: ColorManager.black,
                      fontSize: SizeConfig.headline2Size,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
