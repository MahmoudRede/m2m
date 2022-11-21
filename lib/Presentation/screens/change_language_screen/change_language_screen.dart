import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/localization_cubit/localization_cubit.dart';
import 'package:m2m/business_logic/localization_cubit/localization_states.dart';

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalizationCubit,LocalizationStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('changeLanguage').toString(),
              style: GoogleFonts.roboto(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.headline3Size,
              ),),
            titleSpacing: 0,
            leading: IconButton(
              onPressed: ()=>Navigator.pop(context),
              icon: CashHelper.getData(key: CashHelper.languageKey).toString()=='en'?Icon(
                IconBroken.Arrow___Left_2,
                color: ColorManager.black,
              ):Icon(
                IconBroken.Arrow___Right_2,
                color: ColorManager.black,
              ),
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.height*0.01,
              horizontal: SizeConfig.height*0.02,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(SizeConfig.height*.015),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConfig.height*.015),
                    color: ColorManager.whiteDark,
                  ),
                  child: Row(
                    children: [

                      Icon(
                        Icons.language,
                        color: ColorManager.black,
                      ),

                      SizedBox(width: SizeConfig.height*.015,),

                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.translate('language').toString(),
                          style: GoogleFonts.roboto(
                            color: ColorManager.black,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.height*.02,
                          ),
                        ),
                      ),

                      TextButton(
                          onPressed: (){
                            if(CashHelper.getData(key: CashHelper.languageKey).toString() == 'en'){
                              LocalizationCubit.get(context).changeLanguage(code: 'ar');
                            }
                            else{
                              LocalizationCubit.get(context).changeLanguage(code: 'en');
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.translate(CashHelper.getData(key: CashHelper.languageNameKey).toString()).toString(),
                            style: GoogleFonts.roboto(
                              color: ColorManager.black,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.headline3Size,
                            ),
                          ),
                      ),
                    ],
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
