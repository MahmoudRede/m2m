import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class StartScreenCard extends StatelessWidget {
  final String text;
  final String image;
  final Function onPressed;
  const StartScreenCard({
    Key? key,
    required this.text,
    required this.image,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        alignment: Alignment.centerLeft,
        height: SizeConfig.height*0.135,
        width: SizeConfig.width *0.8,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primary
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            opacity: .7,
            image: AssetImage(image)
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: GoogleFonts.aBeeZee(
              fontSize: SizeConfig.height*.032,
              color: ColorManager.black,
              fontWeight: FontWeight.w600,

            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
