import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  Color? color;
  double? height;
   DefaultButton({
    required this.text,
    required this.onPressed,
    this.color = ColorManager.lightBlue,
    this.height = 50,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        width: SizeConfig.width,
        height:  height,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            color: ColorManager.white,
            fontSize: SizeConfig.headline2Size,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
