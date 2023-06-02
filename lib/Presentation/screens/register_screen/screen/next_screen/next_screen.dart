import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/follow_register/follow_register.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_localization.dart';
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

    List<String> governmentNames=[
      AppLocalizations.of(context)!.translate('alexandria').toString(),
      AppLocalizations.of(context)!.translate('aswan').toString(),
      AppLocalizations.of(context)!.translate('asyut').toString(),
      AppLocalizations.of(context)!.translate('bani_Sweif').toString(),
      AppLocalizations.of(context)!.translate('beheira').toString(),
      AppLocalizations.of(context)!.translate('cairo').toString(),
      AppLocalizations.of(context)!.translate('damietta').toString(),
      AppLocalizations.of(context)!.translate('dakahlia').toString(),
      AppLocalizations.of(context)!.translate('fayoum').toString(),
      AppLocalizations.of(context)!.translate('giza').toString(),
      AppLocalizations.of(context)!.translate('qalyubia').toString(),
      AppLocalizations.of(context)!.translate('qana').toString(),
      AppLocalizations.of(context)!.translate('gharbiya').toString(),
      AppLocalizations.of(context)!.translate('ismailia').toString(),
      AppLocalizations.of(context)!.translate('kafrEl-Sheikh').toString(),
      AppLocalizations.of(context)!.translate('luxor').toString(),
      AppLocalizations.of(context)!.translate('menoufia').toString(),
      AppLocalizations.of(context)!.translate('mursiMuttrah').toString(),
      AppLocalizations.of(context)!.translate('minya').toString(),
      AppLocalizations.of(context)!.translate('northOfSinai').toString(),
      AppLocalizations.of(context)!.translate('port_Said').toString(),
      AppLocalizations.of(context)!.translate('red_Sea').toString(),
      AppLocalizations.of(context)!.translate('sohag').toString(),
      AppLocalizations.of(context)!.translate('south_of_Sina').toString(),
      AppLocalizations.of(context)!.translate('suez').toString(),
      AppLocalizations.of(context)!.translate('theNewValley').toString(),

    ];

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
                                  AppLocalizations.of(context)!.translate('signUp').toString(),
                                  style: GoogleFonts.aBeeZee(
                                      color: ColorManager.black,
                                      fontSize: size.height*.041,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),

                                SizedBox(height: size.height *.01,),

                                Text(
                                  AppLocalizations.of(context)!.translate('singUpMsg').toString(),
                                  style: textManager(
                                      color: Colors.grey.shade500,
                                      fontSize: size.height*.021,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(height: size.height *.02,),

                                // government
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                  padding: const EdgeInsets.symmetric(vertical:5.0,),
                                  height: MediaQuery.of(context).size.height*0.07,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.height*.015,
                                    ),
                                    child: DropdownButton(
                                      menuMaxHeight: SizeConfig.height*.3,
                                      dropdownColor: ColorManager.primary.withOpacity(.95),
                                      elevation: 0,
                                      hint:cubit.governmentDropDown ==''
                                          ?  Text(AppLocalizations.of(context)!.translate('government').toString(), style: textManager(color: Colors.black54,fontSize: SizeConfig.height*.022))
                                          : Text(
                                        cubit.governmentDropDown,
                                        style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                                      ),
                                      underline: Container(),
                                      isExpanded: true,
                                      icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.grey,),
                                      iconSize: 20.0,
                                      style: const TextStyle(color: Colors.white , fontSize: 16.0 , fontWeight: FontWeight.bold),
                                      items: governmentNames.map(
                                            (value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        cubit.changeGovernmentDropDown(value);

                                      },
                                    ),
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
                                    hint: AppLocalizations.of(context)!.translate('age').toString(),
                                    controller: ageController,
                                    textInputType: TextInputType.number,
                                    validText: AppLocalizations.of(context)!.translate('ageValidateMsg').toString(),
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
                                    hint: AppLocalizations.of(context)!.translate('inviteCode').toString(),
                                    controller: codeController,
                                    textInputType: TextInputType.number,
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    top: 10
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional.topStart,
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('selectYourSkills').toString(),
                                      style: GoogleFonts.aBeeZee(
                                          color: ColorManager.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: size.height*.023
                                      ),),
                                  ),
                                ),

                               const SizedBox(height: 10,),

                               // excel && microsoft
                               Padding(
                                 padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                 child: Row(
                                   children: [

                                     // Excel
                                     Expanded(
                                       child: Row(
                                         children: [
                                           IconButton(
                                               onPressed: (){
                                                  setState(() {
                                                    cubit.selectSills1 =!cubit.selectSills1;
                                                    if(cubit.selectSills1==true){
                                                      cubit.userSills1='Excel';
                                                    }
                                                    else{
                                                      cubit.userSills1='';
                                                    }
                                                  });
                                               },
                                               icon: cubit.selectSills1 ?Icon(
                                                 Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                               ):Icon(
                                                 Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                               )
                                           ),

                                           Text('Excel',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                         ],
                                       ),
                                     ),

                                     // Microsoft office
                                     Expanded(
                                       child: Row(
                                         children: [
                                           IconButton(
                                               onPressed: (){
                                                 setState(() {
                                                   cubit.selectSills2 =!cubit.selectSills2;
                                                   if(cubit.selectSills2==true){
                                                     cubit.userSills2='Microsoft office';
                                                   }
                                                   else{
                                                     cubit.userSills2='';
                                                   }
                                                 });
                                               },
                                               icon: cubit.selectSills2 ?Icon(
                                                 Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                               ):Icon(
                                                 Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                               )
                                           ),

                                           Text('Microsoft office',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                         ],
                                       ),
                                     ),

                                   ],
                                 ),
                               ),


                                // Translation && voice over
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  child: Row(
                                    children: [

                                      // Translation
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    cubit.selectSills3 =!cubit.selectSills3;
                                                    if(cubit.selectSills3==true){
                                                      cubit.userSills3='Translation';
                                                    }
                                                    else{
                                                      cubit.userSills3='';
                                                    }
                                                  });
                                                },
                                                icon: cubit.selectSills3 ?Icon(
                                                  Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                                ):Icon(
                                                  Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                                )
                                            ),

                                            Text('Translation',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                          ],
                                        ),
                                      ),

                                      // voice over
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    cubit.selectSills4 =!cubit.selectSills4;
                                                    if(cubit.selectSills4==true){
                                                      cubit.userSills4='Voice over';
                                                    }
                                                    else{
                                                      cubit.userSills4='';
                                                    }
                                                  });
                                                },
                                                icon: cubit.selectSills4 ?Icon(
                                                  Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                                ):Icon(
                                                  Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                                )
                                            ),

                                            Text('Voice over',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                // Adobe Premiere && Photoshop
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  child: Row(
                                    children: [

                                      // Adobe Premiere
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    cubit.selectSills5 =!cubit.selectSills5;
                                                    if(cubit.selectSills5==true){
                                                      cubit.userSills5='Adobe Premiere';
                                                    }
                                                    else{
                                                      cubit.userSills5='';
                                                    }
                                                  });
                                                },
                                                icon: cubit.selectSills5 ?Icon(
                                                  Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                                ):Icon(
                                                  Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                                )
                                            ),

                                            Text('Adobe Premiere',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                          ],
                                        ),
                                      ),

                                      // Photoshop
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    cubit.selectSills6 =!cubit.selectSills6;
                                                    if(cubit.selectSills6==true){
                                                      cubit.userSills6='Photoshop';
                                                    }
                                                    else{
                                                      cubit.userSills6='';
                                                    }
                                                  });
                                                },
                                                icon: cubit.selectSills6 ?Icon(
                                                  Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                                ):Icon(
                                                  Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                                )
                                            ),

                                            Text('Photoshop',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),

                                // Illustrator && Marketing
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                  child: Row(
                                    children: [

                                      // Illustrator
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    cubit.selectSills7 =!cubit.selectSills7;
                                                    if(cubit.selectSills7==true){
                                                      cubit.userSills7='Illustrator';
                                                    }
                                                    else{
                                                      cubit.userSills7='';
                                                    }
                                                  });
                                                },
                                                icon: cubit.selectSills7 ?Icon(
                                                  Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                                ):Icon(
                                                  Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                                )
                                            ),

                                            Text('Illustrator',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                          ],
                                        ),
                                      ),

                                      // Marketing
                                      Expanded(
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: (){
                                                  setState(() {
                                                    cubit.selectSills8 =!cubit.selectSills8;
                                                    if(cubit.selectSills8==true){
                                                      cubit.userSills8='Marketing';
                                                    }
                                                    else{
                                                      cubit.userSills8='';
                                                    }
                                                  });
                                                },
                                                icon: cubit.selectSills8 ?Icon(
                                                  Icons.radio_button_on,size: SizeConfig.height*.03,color: Colors.black,
                                                ):Icon(
                                                  Icons.radio_button_off,size: SizeConfig.height*.03,color: Colors.black,
                                                )
                                            ),

                                            Text('Marketing',style: textManager(color: Colors.black,fontSize: SizeConfig.headline3Size),),

                                          ],
                                        ),
                                      ),

                                    ],
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
                                    text: AppLocalizations.of(context)!.translate('next').toString(),
                                    color: ColorManager.primary,
                                  ),
                                ),
                                SizedBox(height: size.height *.025,),



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
