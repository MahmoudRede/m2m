import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class TaskItemButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  Color? color;
  TaskItemButton({
    required this.text,
    required this.onPressed,
    this.color = ColorManager.secondDarkColor,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height:  SizeConfig.height*.04,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.height*.04,
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: SizeConfig.headline4Size,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
