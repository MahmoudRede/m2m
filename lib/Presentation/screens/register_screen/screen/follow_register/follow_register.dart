import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/follow_register/national_id.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/follow_register/personal_image.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/verified_screen/verified_screen.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/register_cubit/register_cubit.dart';
import 'package:m2m/business_logic/register_cubit/register_state.dart';

class FollowRegister extends StatelessWidget {
  final String name;
  final String phone;
  final String pass;
  final String email;
  final String government;
  final String age;
  final String code;
  final String skills;

  const FollowRegister({
    Key? key,
    required this.name,
    required this.email,
    required this.pass,
    required this.age,
    required this.phone,
    required this.code,
    required this.government,
    required this.skills,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,state){

          if(state is UserRegisterSuccessState){
            navigateTo(context,const VerifiedRegister());
          }
          if(state is UserRegisterErrorState){
            customToast(title: AppLocalizations.of(context)!.translate('registerErrorMsg').toString(), color: ColorManager.red);
          }

        },
        builder: (context,state){
          var cubit= RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: 0.0,
              title: Text(
                AppLocalizations.of(context)!.translate('completeRegistration').toString(),
                style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height*.03
              ),),
              titleSpacing: 0,
              leading: IconButton(
                icon: CashHelper.getData(key: CashHelper.languageKey).toString()=='en'?Icon(
                  IconBroken.Arrow___Left_2,
                  color: ColorManager.black,
                ):Icon(
                  IconBroken.Arrow___Right_2,
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
                        image: cubit.uploadedNationalCard !=null? DecorationImage(
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
                          cubit.getNationalCard().then((value) {
                            navigateTo( context,NationalId());
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10
                          ),
                          child: Text(
                              AppLocalizations.of(context)!.translate('idNationalCard').toString(),
                              style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primary,
                              fontSize: size.height*.025,
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
                          cubit.getPersonalImage().then((value) {
                            navigateTo(context,const PersonalImage());
                          });

                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10
                          ),
                          child: Text(
                              AppLocalizations.of(context)!.translate('personalImage').toString(),
                              style: GoogleFonts.aBeeZee(
                              fontWeight: FontWeight.w600,
                              color: ColorManager.primary,
                              fontSize: size.height*.025,
                              decorationThickness: 2
                          )
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: size.height*.05,),
                  state is UserRegisterLoadingState?
                  const CircularProgressIndicator(
                    color: ColorManager.primary,
                  ):
                  DefaultButton(
                      text: AppLocalizations.of(context)!.translate('signUp').toString(),
                      color: ColorManager.primary,
                      onPressed: (){

                         if(cubit.uploadedNationalCard!=null && cubit.uploadedPersonalImage!=null){

                           cubit.userRegister(
                               email: email,
                               pass: pass,
                               name: name,
                               phone: phone,
                               age: age,
                               government: cubit.governmentDropDown,
                               nationalIdImage:  CashHelper.getData(key: 'nationalId'),
                               personalImage: CashHelper.getData(key: 'personalImage'),
                               inviteCode: code,
                               skills: skills,
                               month: DateTime.now().month.toString(),
                               year: DateTime.now().year.toString(),
                               userSkill1: cubit.userSills1,
                               userSkill2: cubit.userSills2,
                               userSkill3: cubit.userSills3,
                               userSkill4: cubit.userSills4,
                               userSkill5: cubit.userSills5,
                               userSkill6: cubit.userSills6,
                               userSkill7: cubit.userSills7,
                               userSkill8: cubit.userSills8,
                           );

                         }else{

                           customToast(title: AppLocalizations.of(context)!.translate('pleaseSelectRequireImage').toString(), color: Colors.red);
                         }
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
