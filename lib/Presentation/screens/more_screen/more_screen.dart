import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/about_app/about_app.dart';
import 'package:m2m/Presentation/screens/change_language_screen/change_language_screen.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/more_screen/widget/setting_item_widget.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

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
              title: Text(AppLocalizations.of(context)!.translate('settingScreen').toString(),
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
                top: SizeConfig.height*.02,
                left: SizeConfig.height*.02,
                right: SizeConfig.height*.02,
                bottom: SizeConfig.height*.02,
              ),

              child: Column(
                children: [

                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: SizeConfig.height*.08,
                    child: CircleAvatar(
                      radius:SizeConfig.height*.078,
                      backgroundImage:NetworkImage(cubit.userModel!.profileImage),
                    ),
                  ),

                  SizedBox(height: SizeConfig.height*.015,),

                  Text('${CashHelper.getData(key: 'userName')}',
                    style: textManager(color: ColorManager.black,fontSize: SizeConfig.height*.03,),
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: SizeConfig.height*.03,),

                  // about
                  SettingItemWidget(
                    title: 'about',
                    onTap: (){
                      navigateTo(context, const AboutApp());
                    },
                    icon: IconBroken.Info_Circle,
                  ),

                  SizedBox(height: SizeConfig.height*.02,),

                  // language
                  SettingItemWidget(
                    title: 'language',
                    onTap: ()=>navigateTo(context, const ChangeLanguageScreen()),
                    icon: Icons.language,
                  ),

                  SizedBox(height: SizeConfig.height*.02,),

                  // privacyAndTerms
                  SettingItemWidget(
                    title: 'privacyAndTerms',
                    onTap: (){},
                    icon: IconBroken.Setting,
                  ),

                  SizedBox(height: SizeConfig.height*.02,),

                  // notSubscribe
                  SettingItemWidget(
                    title: 'notSubscribe',
                    onTap: (){
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        title: AppLocalizations.of(context)!.translate('unsubscribeTitleMessage').toString(),
                        text: AppLocalizations.of(context)!.translate('unsubscribeWarningMessage').toString(),
                        cancelBtnText: AppLocalizations.of(context)!.translate('cancel').toString(),
                        confirmBtnText: AppLocalizations.of(context)!.translate('notSubscribe').toString(),
                        showCancelBtn: true,
                        onCancelBtnTap: ()=>Navigator.pop(context),
                        backgroundColor: ColorManager.secondDarkColor,
                        onConfirmBtnTap: (){
                          cubit.userUnsubscribe(id: cubit.userModel!.uId).then((value){
                            Navigator.pop(context);
                          });
                        },
                      );
                    },
                    icon: Icons.subscriptions_outlined,
                  ),

                  SizedBox(height: SizeConfig.height*.02,),

                  // deleteAccount
                  SettingItemWidget(
                    title: 'deleteAccount',
                    onTap: (){
                      cubit.deleteUser(userId: cubit.userModel!.uId);
                      navigateAndRemove(context, const LoginScreen());
                      CashHelper.removeData(key: 'uId');
                    },
                    icon: IconBroken.Delete,
                  ),

                ],
              ),
            ),
          );
      },
    );
  }
}
