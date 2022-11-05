import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/more_screen/widget/setting_item_widget.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/constants/constants.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        Size size = MediaQuery.of(context).size;
        var cubit=AppCubit.get(context);
        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('about').toString(),
              style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height*.025
              ),),
            titleSpacing: 0,
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: ColorManager.black,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
            ),
          ),


          body: Container(
            padding: EdgeInsets.only(
              top: SizeConfig.height*.01,
              left: SizeConfig.height*.02,
              right: SizeConfig.height*.02,
              bottom: SizeConfig.height*.02,
            ),

            child: ListView(
              children: [

                Text(
                  aboutApp,
                  style: textManager(
                    color: ColorManager.black,
                    fontSize: SizeConfig.height*.022,
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
