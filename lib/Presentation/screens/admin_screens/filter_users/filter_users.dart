import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/admin_screens/filter_users/widget/filter_user_item.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class SelectUsers extends StatelessWidget {
  const SelectUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> governmentNames=[
      AppLocalizations.of(context)!.translate('alexandria').toString(),
      AppLocalizations.of(context)!.translate('ismailia').toString(),
      AppLocalizations.of(context)!.translate('aswan').toString(),
      AppLocalizations.of(context)!.translate('asyut').toString(),
      AppLocalizations.of(context)!.translate('luxor').toString(),
      AppLocalizations.of(context)!.translate('red_Sea').toString(),
      AppLocalizations.of(context)!.translate('beheira').toString(),
      AppLocalizations.of(context)!.translate('bani_Sweif').toString(),
      AppLocalizations.of(context)!.translate('port_Said').toString(),
      AppLocalizations.of(context)!.translate('south_of_Sina').toString(),
    ];

    List<String> monthNames=[
      AppLocalizations.of(context)!.translate('january').toString(),
      AppLocalizations.of(context)!.translate('february').toString(),
      AppLocalizations.of(context)!.translate('march').toString(),
      AppLocalizations.of(context)!.translate('april').toString(),
      AppLocalizations.of(context)!.translate('may').toString(),
      AppLocalizations.of(context)!.translate('June').toString(),
      AppLocalizations.of(context)!.translate('july').toString(),
      AppLocalizations.of(context)!.translate('august').toString(),
      AppLocalizations.of(context)!.translate('september').toString(),
      AppLocalizations.of(context)!.translate('october').toString(),
      AppLocalizations.of(context)!.translate('November').toString(),
      AppLocalizations.of(context)!.translate('december').toString(),
    ];

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit= AppCubit.get(context);
        Size size= MediaQuery.of(context).size;
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          SizedBox(height: MediaQuery.of(context).size.height*.02,),

                          // title && select all
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: SizeConfig.height*.025,),

                              // title
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('M ',style: GoogleFonts.bungee(
                                        color: ColorManager.black,
                                        fontSize: size.height*.045,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Text('2',style: GoogleFonts.bungee(
                                        color: ColorManager.primary,
                                        fontSize: size.height*.05,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    Text(' M',style: GoogleFonts.bungee(
                                        color: ColorManager.black,
                                        fontSize: size.height*.045,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  ],
                                ),
                              ),

                              // select all
                              Text(AppLocalizations.of(context)!.translate('select_all').toString(),
                                style: textManager(
                                    color: ColorManager.black,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(width: SizeConfig.height*.015,),
                              GestureDetector(
                                onTap: (){},
                                child: const Icon(
                                  Icons.circle_outlined
                                ),
                              ),

                              SizedBox(width: SizeConfig.height*.02,),
                            ],
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height*.02,),


                          // filter
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              // government && skills
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  // Government
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical:5.0,),
                                    height: MediaQuery.of(context).size.height*0.07,
                                    width: MediaQuery.of(context).size.width*0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeConfig.height*.008),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.height*.015,
                                      ),
                                      child: DropdownButton(
                                        dropdownColor: ColorManager.primary.withOpacity(1),
                                        elevation: 0,
                                        hint:cubit.governmentDropDown.isEmpty
                                            ?  Text(AppLocalizations.of(context)!.translate('government').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                            : Text(
                                          cubit.governmentDropDown,
                                          style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                                        ),
                                        underline: Container(),
                                        isExpanded: true,
                                        icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                                        iconSize: 20.0,
                                        style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
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

                                  // Skills
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical:5.0,),
                                    height: MediaQuery.of(context).size.height*0.07,
                                    width: MediaQuery.of(context).size.width*0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeConfig.height*.008),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.height*.015,
                                      ),
                                      child: DropdownButton(
                                        dropdownColor: ColorManager.primary.withOpacity(1),
                                        elevation: 0,
                                        hint:cubit.skillsDropDown.isEmpty
                                            ?  Text(AppLocalizations.of(context)!.translate('skills').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                            : Text(
                                          cubit.skillsDropDown,
                                          style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                                        ),
                                        underline: Container(),
                                        isExpanded: true,
                                        icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                                        iconSize: 20.0,
                                        style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                                        items: governmentNames.map(
                                              (value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (value) {
                                          cubit.changeSkillsDropDown(value);
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height*.02,),

                              // month && year
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [

                                  // month
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical:5.0,),
                                    height: MediaQuery.of(context).size.height*0.07,
                                    width: MediaQuery.of(context).size.width*0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeConfig.height*.008),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.height*.015,
                                      ),
                                      child: DropdownButton(
                                        dropdownColor: ColorManager.primary.withOpacity(1),
                                        elevation: 0,
                                        hint:cubit.monthDropDown.isEmpty
                                            ?  Text(AppLocalizations.of(context)!.translate('month').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                            : Text(
                                          cubit.monthDropDown,
                                          style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                                        ),
                                        underline: Container(),
                                        isExpanded: true,
                                        icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                                        iconSize: 20.0,
                                        style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                                        items: monthNames.map(
                                              (value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (value) {
                                          cubit.changeMonthDropDown(value);
                                        },
                                      ),
                                    ),
                                  ),

                                  // year
                                  Container(
                                    padding: const EdgeInsets.symmetric(vertical:5.0,),
                                    height: MediaQuery.of(context).size.height*0.07,
                                    width: MediaQuery.of(context).size.width*0.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(SizeConfig.height*.008),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.height*.015,
                                      ),
                                      child: DropdownButton(
                                        dropdownColor: ColorManager.primary.withOpacity(1),
                                        elevation: 0,
                                        hint:cubit.yearDropDown.isEmpty
                                            ?  Text(AppLocalizations.of(context)!.translate('year').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                            : Text(
                                          cubit.yearDropDown,
                                          style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                                        ),
                                        underline: Container(),
                                        isExpanded: true,
                                        icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                                        iconSize: 20.0,
                                        style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                                        items: monthNames.map(
                                              (value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (value) {
                                          cubit.changeYearDropDown(value);
                                        },
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height*.02,),

                              // package
                              Container(
                                padding: const EdgeInsets.symmetric(vertical:5.0,),
                                height: MediaQuery.of(context).size.height*0.07,
                                width: MediaQuery.of(context).size.width*0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(SizeConfig.height*.008),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.height*.015,
                                  ),
                                  child: DropdownButton(
                                    dropdownColor: ColorManager.primary.withOpacity(1),
                                    elevation: 0,
                                    hint:cubit.packageDropDown.isEmpty
                                        ?  Text(AppLocalizations.of(context)!.translate('package').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                        : Text(
                                      cubit.packageDropDown,
                                      style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                                    ),
                                    underline: Container(),
                                    isExpanded: true,
                                    icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                                    iconSize: 20.0,
                                    style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                                    items: monthNames.map(
                                          (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      cubit.changePackageDropDown(value);
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(height: SizeConfig.height*.02,),


                            ],
                          ),

                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index){
                                return const FilterUserItem();
                              },
                              separatorBuilder: (context,index){
                                return SizedBox(height: SizeConfig.height*.02,);
                              },
                              itemCount: 20
                          ),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height:SizeConfig.height*.01 ,),

                  // send task button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:  SizeConfig.height*.05,
                    ),
                    child: DefaultButton(
                        text: AppLocalizations.of(context)!.translate('send_task').toString(),
                        onPressed: (){

                        }
                    ),
                  ),
                ],
              ),
            ),
          );
          },
    );
  }
}
