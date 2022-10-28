import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/profile_screen/screen/open_profile_image.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

        if(state is PickProfileImageSuccessState){

          navigateTo(context, const OpenProfileImage());
        }

      },
      builder: (context,state){

        var cubit=AppCubit.get(context);

        return Scaffold(


          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('profileScreen').toString(),
              style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.height*.03
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

          body: SafeArea(
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [

                  Container(
                    padding: EdgeInsets.all(SizeConfig.height*.02),
                    margin: EdgeInsets.only(top: SizeConfig.height*.15),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorManager.black.withOpacity(.9),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(SizeConfig.height*.03),
                          topLeft:  Radius.circular(SizeConfig.height*.03),
                        )
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: SizeConfig.height*.06,),

                         // personal information
                         Text(AppLocalizations.of(context)!.translate('personalInformation').toString(),
                           style: textManager(color: ColorManager.white,fontWeight: FontWeight.w600)
                         ),

                        SizedBox(height: SizeConfig.height*.01,),

                        const Divider(color: Colors.white,),

                        SizedBox(height: SizeConfig.height*.02,),

                        // name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${AppLocalizations.of(context)!.translate('name').toString()} :',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.025,fontWeight: FontWeight.w500)
                            ),

                            SizedBox(width: SizeConfig.height*.01,),

                            Expanded(
                              child: Text('${CashHelper.getData(key: 'userName')}',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.02,),
                                overflow: TextOverflow.ellipsis,

                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: SizeConfig.height*.02,),

                        // email
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${AppLocalizations.of(context)!.translate('email').toString()} :',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.025,fontWeight: FontWeight.w500)
                            ),

                            SizedBox(width: SizeConfig.height*.01,),

                            Expanded(
                              child: Text('${CashHelper.getData(key: 'userEmail')}',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.02,),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                          ],
                        ),

                        SizedBox(height: SizeConfig.height*.02,),

                        // phone
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${AppLocalizations.of(context)!.translate('phone').toString()} :',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.025,fontWeight: FontWeight.w500)
                            ),

                            SizedBox(width: SizeConfig.height*.01,),

                            Expanded(
                              child: Text('${CashHelper.getData(key: 'userPhone')}',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.02,fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,

                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: SizeConfig.height*.02,),

                        // government
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${AppLocalizations.of(context)!.translate('government').toString()} :',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.025,fontWeight: FontWeight.w500)
                            ),

                            SizedBox(width: SizeConfig.height*.01,),

                            Expanded(
                              child: Text('${CashHelper.getData(key: 'userGovernment')}',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.02,),
                                overflow: TextOverflow.ellipsis,

                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: SizeConfig.height*.02,),

                        // package
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${AppLocalizations.of(context)!.translate('package').toString()} :',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.025,fontWeight: FontWeight.w500)
                            ),

                            SizedBox(width: SizeConfig.height*.01,),

                            Expanded(
                              child: Text('${CashHelper.getData(key:'userPackage')}',
                                style: textManager(color: ColorManager.white,fontSize: SizeConfig.height*.02,),
                                overflow: TextOverflow.ellipsis,

                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: SizeConfig.height*.02,),

                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Divider(color: Colors.white,),
                        ),

                        SizedBox(height: SizeConfig.height*.02,),

                        // call center
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${AppLocalizations.of(context)!.translate('callCenter').toString()} :',
                                style: textManager(color: ColorManager.white)
                            ),

                            SizedBox(width: SizeConfig.height*.02,),

                            Text('01277556432',style: textManager(color: ColorManager.white)),
                          ],
                        ),

                        SizedBox(height: SizeConfig.height*.02,),

                        // technical support
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text('${AppLocalizations.of(context)!.translate('technicalSupport').toString()} :',
                                style: textManager(color: ColorManager.white)
                            ),

                            SizedBox(width: SizeConfig.height*.02,),

                            Text('01277556432',style: textManager(color: ColorManager.white)),
                          ],
                        ),
                      ],

                    ),
                  ),

                   // profile image
                   Positioned(
                    top: SizeConfig.height*.04,
                    left: SizeConfig.height*.02,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: SizeConfig.height*.08,
                          child: CircleAvatar(
                            radius:SizeConfig.height*.078,
                            backgroundImage:NetworkImage(cubit.userModel!.profileImage),
                          ),
                        ),
                        Positioned(
                          right: SizeConfig.height*.00,
                          bottom: SizeConfig.height*.00,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: (){
                                  cubit.getProfileImage();
                                },
                                icon: const Icon(Icons.camera_alt)
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),

            ),
          ),
        );
      },
    );
  }
}