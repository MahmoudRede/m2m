import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class VerifiedRegister extends StatefulWidget {
  const VerifiedRegister({Key? key}) : super(key: key);

  @override
  State<VerifiedRegister> createState() => _VerifiedRegisterState();
}

class _VerifiedRegisterState extends State<VerifiedRegister> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3),(){
      return navigateTo(LoginScreen(), context);
    });
    super.initState();
  }

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
            toolbarHeight: 0.0,
            titleSpacing: 0,
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: ColorManager.black,
              ),
              onPressed: (){

              },
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
            ),
          ),
          body: Center(
            child: Container(
              height: size.height*.5,
              width: size.width,

              child: Lottie.asset(AssetsManager.verifiedRegister),
            ),
          ),


        );
      },
    );
  }
}
