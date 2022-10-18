import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/investment_screen/screen/investment_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/register_screen/register_screen.dart';
import 'package:m2m/Presentation/screens/start_screen/screen/start_screen.dart';
import 'package:m2m/Presentation/screens/start_screen/widget/startScreenCard.dart';
import 'package:m2m/Presentation/screens/start_screen/widget/start_screen_custom_title.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/login_cubit/login_cubit.dart';
import 'package:m2m/business_logic/login_cubit/login_state.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=LoginCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 0.0,
              backwardsCompatibility: false,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Image(
                    height:size.height*.34,
                    width: size.width,
                    fit: BoxFit.cover,
                    image: const AssetImage(AssetsManager.login),
                  ),
                ),
                Positioned(
                  top: size.height*.26,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(60)
                        )
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: size.height *.04,),
                        const StartScreenCustomTitle(),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 10
                          ),
                          child: Text(
                            'By signing you accept to our Terms of use and privacy policy',
                            style: textManager(
                              color: Colors.grey.shade700,
                              fontSize: size.height*.018,
                              fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        SizedBox(height: size.height *.05,),
                        StartScreenCard(
                          image: AssetsManager.marketing,
                          onPressed: (){
                              navigateTo( context,const PackageScreen(),);
                          },
                          text: 'Package',
                        ),
                        SizedBox(height: size.height *.04,),
                        StartScreenCard(
                          image: AssetsManager.investment,
                          onPressed: (){
                            navigateTo( context,const InvestmentScreen());
                          },
                          text: 'Investment',
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )

        );

      },
    );
  }
}
