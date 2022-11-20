import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/business_logic/app_localization.dart';

class SettingItemWidget extends StatelessWidget {

  final String title;
  final Function onTap;
  final IconData icon;
  const SettingItemWidget({Key? key,required this.title,required this.icon,required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(SizeConfig.height*.015),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SizeConfig.height*.015),
            color: Colors.grey[300],
        ),
        child: Row(
          children: [

            Icon(icon,),

            SizedBox(width: SizeConfig.height*.015,),

            Expanded(
              child: Text(AppLocalizations.of(context)!.translate(title).toString(),
                style: GoogleFonts.roboto(
                    color: ColorManager.black,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.height*.02,
                ),),
            ),


            const Icon(IconBroken.Arrow___Right_2),

          ],
        ),
      ),
    );
  }
}
