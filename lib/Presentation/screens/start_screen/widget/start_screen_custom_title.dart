import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class StartScreenCustomTitle extends StatelessWidget {
  const StartScreenCustomTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return  Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.topPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('M ',style: GoogleFonts.bungee(
              color: ColorManager.black,
              fontSize: size.height*.065,
              fontWeight: FontWeight.bold
          ),),
          Text('2',style: GoogleFonts.bungee(
              color: ColorManager.primary,
              fontSize: size.height*.07,
              fontWeight: FontWeight.bold
          ),),
          Text(' M',style: GoogleFonts.bungee(
              color: ColorManager.black,
              fontSize: size.height*.065,
              fontWeight: FontWeight.bold
          ),),
        ],
      ),
    );
  }
}
