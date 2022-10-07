import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  Color? color;
   DefaultButton({
    required this.text,
    required this.onPressed,
    this.color = ColorManager.lightBlue,
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
        height:  SizeConfig.height*.065,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: SizeConfig.height*.025,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}