import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/admin_screens/filter_users/filter_users.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
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

  GlobalKey<FormState> formKey = GlobalKey();

  bool isPassword=true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
           if(state is UserLoginSuccessState){

             customToast(title: 'Welcome Back',color:ColorManager.primary );
             CashHelper.saveData(key: 'uId',value: state.uid);
             AppCubit.get(context).getUser();
             navigateAndRemove(context,const PackageScreen());

           }

           if(state is UserLoginErrorState){

             customToast(title: 'Email or Password isn\'t correct',color:ColorManager.red );

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
                              'Welcome back',
                              style: GoogleFonts.aBeeZee(
                                  color: ColorManager.black,
                                  fontSize: size.height*.045,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            SizedBox(height: size.height *.01,),
                            Text(
                              'Login to your account',
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
                                hint: 'Email',
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                validText: 'Please enter your email',
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
                                hint: 'Password',
                                isPassword: isPassword,
                                controller: passController,
                                textInputType: TextInputType.visiblePassword,
                                validText: 'Please enter your password',
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: (){},
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: Text(
                                    'Forget password',
                                    style: textManager(
                                      color: ColorManager.lightBlue,
                                      fontSize: SizeConfig.headline3Size,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height *.045,),
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

                                    if( emailController.text == 'M2M2022@gmail.com' && passController.text == '123456789')
                                      {
                                        navigateTo(context, const SelectUsers());
                                        customToast(title: 'Welcome to Dashboard', color: ColorManager.primary);
                                      }
                                    else{
                                      cubit.userLogin(
                                          email: emailController.text,
                                          password: passController.text
                                      );
                                    }

                                  }
                                },
                                color: ColorManager.lightBlue,
                                text: 'Sign in',
                              ),
                            ),
                            SizedBox(height: size.height *0.05,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: textManager(
                                      color: Colors.grey.shade700,
                                      fontSize: size.height*.02,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    navigateAndRemove(context,const RegisterScreen());
                                  },
                                  child: Text(
                                    ' Sign Up',
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
              )

          );

        },
    );
  }
}
