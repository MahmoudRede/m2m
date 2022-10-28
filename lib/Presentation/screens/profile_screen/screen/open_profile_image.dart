import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/profile_screen/screen/profile_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class OpenProfileImage extends StatelessWidget {
  const OpenProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

         if(state is UploadProfileImageSuccessState){
           customToast(title: AppLocalizations.of(context)!.translate('profileImageSave').toString(), color: ColorManager.primary);
           navigateAndRemove(context, const ProfileScreen());
         }

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
          return Scaffold(

            // title
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              title: Text(AppLocalizations.of(context)!.translate('profileImage').toString(),
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
                margin: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    SizedBox(height: SizeConfig.height*.02,),


                    // profile image
                    GestureDetector(
                      onTap: (){
                        cubit.getProfileImage();
                      },
                      child: Container(
                          height: SizeConfig.height*.6,
                        width: SizeConfig.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: ColorManager.primary,
                            ),
                            image:DecorationImage(
                              image:  FileImage(cubit.profileImage!)
                            )
                        ),
                      ),
                    ),

                    const Spacer(),

                    // upload profile image
                    state is UploadProfileImageLoadingState ?
                    const Align(
                      alignment: Alignment.topRight,
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    ):
                    Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(
                        backgroundColor: ColorManager.primary,
                        onPressed: (){
                          cubit.uploadUserImage();
                        },
                        child: const Icon(
                            IconBroken.Arrow___Right_2
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.height*.02,)

                  ],
                ),
              ),
            ),

          );
      },
    );
  }
}
