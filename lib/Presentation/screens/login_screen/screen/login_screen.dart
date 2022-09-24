import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/register_screen/register_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController=TextEditingController();

  var passController=TextEditingController();

  @override
  var formKey = GlobalKey<FormState>();

  bool isPassword=true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                              fontSize: SizeConfig.headline4Size,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height *.05,),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10
                      ),
                      child: DefaultButton(
                        onPressed: (){
                           if(formKey.currentState!.validate()){

                           }
                        },
                        color: ColorManager.lightBlue,
                        text: 'Sign in',
                      ),
                    ),
                    SizedBox(height: size.height *0.1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: textManager(
                              color: ColorManager.black,
                              fontSize: SizeConfig.headline3Size,
                              fontWeight: FontWeight.w500,
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            navigateAndRemove(RegisterScreen(), context);
                          },
                          child: Text(
                            ' Sign up',
                            style: textManager(
                                color: ColorManager.lightBlue,
                                fontSize: SizeConfig.headline3Size,
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
  }
}
