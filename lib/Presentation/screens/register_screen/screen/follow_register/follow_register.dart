import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/register_screen/verified_screen/verified_screen.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class FollowRegister extends StatelessWidget {
  const FollowRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              title: Text('Complete Registration',style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height*.03
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
              backwardsCompatibility: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white
              ),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10
              ),
              child: Column(
                children: [
                  Container(
                    height: size.height*.27,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ColorManager.primary,
                        ),
                        image: cubit.uploadedNationalCard!=null? DecorationImage(
                          image:  FileImage(cubit.uploadedNationalCard!) ,
                        ):const DecorationImage(
                             image: AssetImage(AssetsManager.idCard),
                          fit: BoxFit.cover
                       )
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          cubit.getNationalCard();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10
                          ),
                          child: Text(
                              'Id National Card',style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primary,
                              fontSize: size.height*.027,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2
                          )
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: size.height*.02,),
                  Container(
                    height: size.height*.27,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ColorManager.primary,
                        ),
                        image:cubit.uploadedPersonalImage!=null? DecorationImage(
                          image:  FileImage(cubit.uploadedPersonalImage!) ,
                        ):const DecorationImage(
                          image: AssetImage(AssetsManager.selife),
                            fit: BoxFit.cover

                        )
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          cubit.getPersonalImage();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10
                          ),
                          child: Text(
                              'Personal Image',style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primary,
                              fontSize: size.height*.027,
                              decoration: TextDecoration.underline,
                              decorationThickness: 2
                          )
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: size.height*.05,),
                  DefaultButton(
                      text: 'Send',
                      color: ColorManager.primary,
                      onPressed: (){
                         navigateTo(VerifiedRegister(), context);
                      }
                  )
                ],
              ),
            ),


          );
        },
    );
  }
}
