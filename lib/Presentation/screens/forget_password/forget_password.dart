import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  static TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

         if(state is ForgetPasswordSuccessState){

            customToast(title: AppLocalizations.of(context)!.translate('verifyEmail').toString(), color: ColorManager.primary);

         }


      },
      builder: (context,state){
        var cubit=AppCubit.get(context);

        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
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
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal:SizeConfig.height*.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: SizeConfig.height*.03,),

                  // title
                  Text(AppLocalizations.of(context)!.translate('forgetPassword').toString(),
                    style: textManager(
                      color: Colors.black,
                      fontSize: SizeConfig.height*.034,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  SizedBox(height: SizeConfig.height*.01,),

                  // describtion
                  Text(AppLocalizations.of(context)!.translate('forgetPasswordMsg').toString(),
                    style: textManager(
                        color: Colors.grey,
                        fontSize: SizeConfig.height*.018,
                    ),
                  ),

                  SizedBox(height: SizeConfig.height*.12,),


                  // email form filed
                  DefaultFormField(
                      hint: AppLocalizations.of(context)!.translate('email').toString(),
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: SizeConfig.height*.06,),

                  // send button

                  state is ForgetPasswordLoadingState?
                  const Center(
                    child:CircularProgressIndicator(),
                  ):
                  DefaultButton(
                      text: AppLocalizations.of(context)!.translate('send').toString(),
                      onPressed: ()=>cubit.forgetPassword(email: emailController.text),

                  ),

                ],
              ),
            ),
          ),
        );

      },


    );
  }
}
