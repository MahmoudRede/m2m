import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/admin_screens/admin_home/admin_home.dart';
import 'package:m2m/Presentation/screens/forget_password/forget_password.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/screens/privacy_terms/privacy_terms.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/register_screen/register_screen.dart';
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
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/login_cubit/login_cubit.dart';
import 'package:m2m/business_logic/login_cubit/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();

  var passController=TextEditingController();

  bool isCheckBoxTrue = false;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isPassword=true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
           if(state is UserLoginSuccessState){

             customToast(title: AppLocalizations.of(context)!.translate('loginScreenWelcomeMsg').toString(),color:ColorManager.primary );
             CashHelper.saveData(key: 'uId',value: state.uid);
             AppCubit.get(context).getUser();
             navigateAndRemove(context,const PackageScreen());

           }

           if(state is UserLoginErrorState){

             customToast(title: AppLocalizations.of(context)!.translate('loginScreenErrorMsg').toString(),color:ColorManager.red );

           }
        },
        builder: (context,state){
          var cubit=LoginCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                toolbarHeight: 0.0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white
                ),
              ),
              body: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: SizeConfig.height,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          child: Image(
                            height:size.height*.32,
                            width: size.width,
                            fit: BoxFit.cover,
                            image: const AssetImage(AssetsManager.login),
                          ),
                        ),
                        Positioned(
                          top: size.height*.22,
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
                                SizedBox(height: size.height *.05,),
                                Text(
                                  AppLocalizations.of(context)!.translate('loginScreenWelcomeMsg').toString(),
                                  style: GoogleFonts.aBeeZee(
                                      color: ColorManager.black,
                                      fontSize: size.height*.045,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.translate('loginScreenWelcomeMsg2').toString(),
                                  style: textManager(
                                    color: Colors.grey.shade500,
                                    fontSize: size.height*.022,

                                  ),
                                ),
                                SizedBox(height: size.height *.05,),

                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: DefaultFormField(
                                    prefixWidget: const Icon(
                                        IconBroken.User
                                    ),
                                    hint: AppLocalizations.of(context)!.translate('email').toString(),
                                    controller: emailController,
                                    textInputType: TextInputType.emailAddress,
                                    validText: AppLocalizations.of(context)!.translate('emailValidateMsg').toString(),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: DefaultFormField(
                                    prefixWidget: const Icon(
                                        IconBroken.Lock
                                    ),
                                    suffixIcon: isPassword? Icons.visibility_off:Icons.visibility,
                                    suffixFunction: (){
                                      setState(() {
                                        isPassword=!isPassword;

                                      });
                                    },
                                    hint: AppLocalizations.of(context)!.translate('password').toString(),
                                    isPassword: isPassword,
                                    controller: passController,
                                    textInputType: TextInputType.visiblePassword,
                                    validText: AppLocalizations.of(context)!.translate('passwordValidateMsg').toString(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: ()=>navigateTo(context, const ForgetPassword()),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.translate('forgetPassword').toString(),
                                        style: textManager(
                                          color: ColorManager.lightBlue,
                                          fontSize: SizeConfig.headline3Size,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),


                                // privacy and terms
                                SizedBox(
                                  height: size.height * .04,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                        value: isCheckBoxTrue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(2.0),
                                        ),
                                        side: MaterialStateBorderSide.resolveWith(
                                              (states) => BorderSide(
                                              width: 1.0, color: ColorManager.grey),
                                        ),
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isCheckBoxTrue = true;
                                          });
                                        }),
                                    Text.rich(
                                      TextSpan(
                                          text: AppLocalizations.of(context)!.translate('agreeTooOur').toString(),
                                          style: textManager(color: ColorManager.grey),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: AppLocalizations.of(context)!.translate('privacyPolicies').toString(),
                                              style: TextStyle(
                                                fontSize: SizeConfig.height*.02,
                                                color: ColorManager.primary,
                                                decoration: TextDecoration.underline,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                        const PrivacyPolicies(),
                                                      ));
                                                  // code to open / launch terms of service link here
                                                },
                                            ),
                                          ]),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * .02,
                                ),


                                // login button
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: state is UserLoginLoadingState?
                                    const CircularProgressIndicator(
                                      color: ColorManager.primary,
                                    )
                                    :DefaultButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){

                                         if(isCheckBoxTrue==true){

                                           if( emailController.text == 'M2M2022@gmail.com' && passController.text == '123456789')
                                           {
                                             navigateTo(context, const AdminHome());
                                             customToast(title: AppLocalizations.of(context)!.translate('welcomeToDashboard').toString(), color: ColorManager.primary);
                                           }
                                           else{
                                             cubit.userLogin(
                                                 email: emailController.text,
                                                 password: passController.text
                                             );
                                           }

                                         }
                                         else{

                                           customToast(title: AppLocalizations.of(context)!.translate('privacyPoliciesMsg').toString(), color: ColorManager.red);

                                         }

                                      }
                                    },
                                    color: ColorManager.lightBlue,
                                    text: AppLocalizations.of(context)!.translate('signIn').toString(),
                                  ),
                                ),
                                SizedBox(height: size.height *0.05,),

                                // don't have an account
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                    AppLocalizations.of(context)!.translate('doNotHaveAccount').toString(),
                                      style: textManager(
                                          color: Colors.grey.shade700,
                                          fontSize: size.height*.02,
                                          fontWeight: FontWeight.w500
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        navigateTo(context,const RegisterScreen());
                                      },
                                      child: Text(
                                        ' ${AppLocalizations.of(context)!.translate('signUp').toString()}',
                                        style: textManager(
                                            color: ColorManager.primary,
                                            fontSize: size.height*.023,
                                            fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )

          );

        },
    );
  }
}
