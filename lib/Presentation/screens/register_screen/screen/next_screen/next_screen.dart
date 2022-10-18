import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/follow_register/follow_register.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/register_cubit/register_cubit.dart';
import 'package:m2m/business_logic/register_cubit/register_state.dart';

class NextScreen extends StatefulWidget {

  final String userName;
  final String email;
  final String password;
  final String phone;

  const NextScreen({Key? key,
    required this.userName,
    required this.email,
    required this.password,
    required this.phone,
  }) : super(key: key);

  @override
  State<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {

  var ageController=TextEditingController();
  var governmentController=TextEditingController();
  var codeController=TextEditingController();
  var skillController=TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

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
                                        IconBroken.Info_Circle
                                    ),
                                    hint: 'Governorate',
                                    controller: governmentController,
                                    textInputType: TextInputType.text,
                                    validText: 'Please enter your governorate',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: DefaultFormField(
                                    prefixWidget: const Icon(
                                        Icons.numbers
                                    ),
                                    hint: 'Age',
                                    controller: ageController,
                                    textInputType: TextInputType.number,
                                    validText: 'Please enter your age',
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: DefaultFormField(
                                    prefixWidget: const Icon(
                                        Icons.code
                                    ),
                                    hint: 'Invite code',
                                    controller: codeController,
                                    textInputType: TextInputType.number,
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: DefaultFormField(
                                    hint: 'Write your skills here...',
                                    maxLines: 5,
                                    controller: skillController,
                                    textInputType: TextInputType.text,
                                    validText: 'Please enter your skills',
                                  ),
                                ),

                                SizedBox(height: size.height *.015,),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: DefaultButton(
                                    onPressed: (){
                                      if(formKey.currentState!.validate()){
                                         navigateTo(context, FollowRegister(
                                             name: widget.userName,
                                             email: widget.email,
                                             pass: widget.password,
                                             age: ageController.text,
                                             phone: widget.phone,
                                             code: codeController.text,
                                             government: governmentController.text,
                                             skills: skillController.text
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
                                        navigateAndRemove(context,const LoginScreen());
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
