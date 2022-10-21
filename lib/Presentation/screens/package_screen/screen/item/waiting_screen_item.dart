import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/widget/custom_title.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_localization.dart';

class WaitingScreenItem extends StatelessWidget {
  const WaitingScreenItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: SizeConfig.height,
          width: SizeConfig.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: SizeConfig.height*.06,),

              // title
              const CustomTitle(),

              // Lottie Image
              Lottie.asset('assets/images/waiting_image.json',height: SizeConfig.height*.5,width:SizeConfig.height*.5),

              // Text
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.height*.02
                ),
                child: Text(AppLocalizations.of(context)!.translate('waiting').toString(),
                  style: textManager(
                      color: ColorManager.black,
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
