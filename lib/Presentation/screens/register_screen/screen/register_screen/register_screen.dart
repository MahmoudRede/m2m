import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/next_screen/next_screen.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/register_cubit/register_cubit.dart';
import 'package:m2m/business_logic/register_cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var emailController=TextEditingController();
  var passController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isPassword=true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,state){

        },
        builder: (context,state){
            var cubit=RegisterCubit.get(context);
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
                      height: size.height*1.05,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            child: Image(
                              height:size.height*.22,
                              width: size.width,
                              fit: BoxFit.cover,
                              image: const AssetImage(AssetsManager.login),
                            ),
                          ),
                          Positioned(
                            top: size.height*.15,
                            child: Container(
                              width: size.width,
                              height: size.height,
                              decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(60)
                                  )
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: size.height *.03,),
                                    Text(
                                      'Register',
                                      style: GoogleFonts.aBeeZee(
                                          color: ColorManager.black,
                                          fontSize: size.height*.041,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    SizedBox(height: size.height *.01,),
                                    Text(
                                      'Create your new account',
                                      style: textManager(
                                          color: Colors.grey.shade500,
                                          fontSize: size.height*.021,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                    SizedBox(height: size.height *.03,),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10
                                      ),
                                      child: DefaultFormField(
                                        prefixWidget: const Icon(
                                            IconBroken.User1,
                                        ),
                                        hint: 'User Name',
                                        controller: nameController,
                                        textInputType: TextInputType.name,
                                        validText: 'Please enter your userName',
                                      ),
                                    ),
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
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10
                                      ),
                                      child: DefaultFormField(
                                        prefixWidget: const Icon(
                                            IconBroken.Call
                                        ),
                                        hint: 'Phone Number',
                                        controller: phoneController,
                                        textInputType: TextInputType.phone,
                                        validText: 'Please enter your phoneNumber',
                                      ),
                                    ),
                                    SizedBox(height: size.height *.015,),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                          vertical: 10
                                      ),
                                      child: state is UserRegisterLoadingState?
                                        const CircularProgressIndicator(
                                          color: ColorManager.primary,
                                        ):
                                        DefaultButton(
                                        onPressed: (){

                                          if(formKey.currentState!.validate()){
                                            navigateTo( context,NextScreen(
                                              userName: nameController.text,
                                              email: emailController.text,
                                              password: passController.text,
                                              phone: phoneController.text,
                                            ));
                                          }

                                        },
                                        text: 'Next',
                                        color: ColorManager.primary,
                                      ),
                                    ),
                                    SizedBox(height: size.height *.025,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Already have an account?',
                                          style: textManager(
                                              color: Colors.grey.shade700,
                                              fontSize: size.height*.02,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            navigateAndRemove( context, LoginScreen(),);
                                          },
                                          child: Text(
                                            ' Sign in',
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
