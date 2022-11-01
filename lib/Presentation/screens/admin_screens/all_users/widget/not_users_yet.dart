import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/admin_screens/admin_home/admin_home.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';

class NotUsersYet extends StatelessWidget {
  const NotUsersYet ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height,
      color: ColorManager.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.height*0.03,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Lottie.asset("assets/images/empty.json"),

            SizedBox(height: SizeConfig.height*0.02,),

            Text(AppLocalizations.of(context)!.translate('notUserEnterYet').toString(),
              style: GoogleFonts.roboto(
                fontSize: SizeConfig.headline3Size,
                color: ColorManager.secondDarkColor,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: SizeConfig.height*0.1,),

            DefaultButton(
              text: AppLocalizations.of(context)!.translate('backToHome').toString(),
              onPressed: ()=>navigateAndRemove(context, const AdminHome()),
              color: ColorManager.secondDarkColor,
            ),
          ],
        ),
      ),
    );
  }
}
