import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
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
            color: ColorManager.whiteDark,
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


            CashHelper.getData(key: CashHelper.languageKey).toString()=='en'?Icon(
              IconBroken.Arrow___Right_2,
              color: ColorManager.black,
            ):Icon(
              IconBroken.Arrow___Left_2,
              color: ColorManager.black,
            ),

          ],
        ),
      ),
    );
  }
}
