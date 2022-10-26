import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class CustomBoxInformation extends StatelessWidget {
  const CustomBoxInformation({
    Key? key,
    required this.boxIcon,
    required this.label,
  }) : super(key: key);

  final IconData boxIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width * 0.25,
      height: SizeConfig.height * 0.11,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.6,
            color: ColorManager.lightGrey2,
          ),
          borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          SizeConfig.height*0.005,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              boxIcon,
              color: ColorManager.lightGrey2,
            ),
            SizedBox(
              height: SizeConfig.height*0.015,
            ),
            Text(
              label,
              style: GoogleFonts.roboto(
                  color: ColorManager.lightGrey2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
