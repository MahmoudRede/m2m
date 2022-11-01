import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/admin_screens/all_users/single_user.dart';
import 'package:m2m/Presentation/screens/admin_screens/all_users/widget/not_users_yet.dart';
import 'package:m2m/Presentation/screens/admin_screens/all_users/widget/user_item.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AppCubit.get(context).usersFilterion(
        government: AppCubit.get(context).governmentDropDown,
        month: AppCubit.get(context).monthDropDown,
        year: AppCubit.get(context).yearDropDown,
        package: AppCubit.get(context).packageDropDown,
        skill: AppCubit.get(context).skillsDropDown
    );
  }

  List<String> monthNames=[
    '1','2','3','4','5','6','7','8','9','10','11','12'
  ];

  List<String> yearNames=[
    '2022','2023','2024','2025','2026','2027','2028','2029','2030',
  ];

  List<String> packageNames=[
    '250','600','1000','2000',
  ];

  List<String> skillsNames=[
    'Excel','PhotoShop','Microsoft office','Marketing','Illustrator','Adobe Premiere','Translation','Voice over',
  ];

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
      AppLocalizations.of(context)!.translate('giza').toString(),
      AppLocalizations.of(context)!.translate('dakahlia').toString(),
      AppLocalizations.of(context)!.translate('damietta').toString(),
      AppLocalizations.of(context)!.translate('sohag').toString(),
      AppLocalizations.of(context)!.translate('suez').toString(),
      AppLocalizations.of(context)!.translate('northOfSinai').toString(),
      AppLocalizations.of(context)!.translate('gharbiya').toString(),
      AppLocalizations.of(context)!.translate('fayoum').toString(),
      AppLocalizations.of(context)!.translate('cairo').toString(),
      AppLocalizations.of(context)!.translate('qalyubia').toString(),
      AppLocalizations.of(context)!.translate('qana').toString(),
      AppLocalizations.of(context)!.translate('kafrEl-Sheikh').toString(),
      AppLocalizations.of(context)!.translate('mursiMuttrah').toString(),
      AppLocalizations.of(context)!.translate('menoufia').toString(),
      AppLocalizations.of(context)!.translate('minya').toString(),
      AppLocalizations.of(context)!.translate('theNewValley').toString(),

    ];



    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppCubit.get(context);
        Size size=MediaQuery.of(context).size;

        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('allUser').toString(),
              style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height*.03
              ),),
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
            child: cubit.users.isNotEmpty?
            Column(
              children: [

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
                              hint:cubit.governmentDropDown =='All'
                                  ?  Text(AppLocalizations.of(context)!.translate('government').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                  : Text(
                                cubit.governmentDropDown,
                                style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                              ),
                              underline: Container(),
                              isExpanded: true,
                              icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
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
                                cubit.usersFilterion(
                                    government: cubit.governmentDropDown,
                                    month: cubit.monthDropDown,
                                    year: cubit.yearDropDown,
                                    package: cubit.packageDropDown,
                                    skill: AppCubit.get(context).skillsDropDown

                                );
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
                              hint:cubit.skillsDropDown =='All'
                                  ?  Text(AppLocalizations.of(context)!.translate('skills').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                  : Text(
                                cubit.skillsDropDown,
                                style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                              ),
                              underline: Container(),
                              isExpanded: true,
                              icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                              iconSize: 20.0,
                              style: const TextStyle(color: Colors.white , fontSize: 16.0 , fontWeight: FontWeight.bold),
                              items: skillsNames.map(
                                    (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                cubit.changeSkillsDropDown(value);
                                cubit.usersFilterion(
                                    government: cubit.governmentDropDown,
                                    month: cubit.monthDropDown,
                                    year: cubit.yearDropDown,
                                    package: cubit.packageDropDown,
                                    skill: AppCubit.get(context).skillsDropDown

                                );
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
                              hint:cubit.monthDropDown =='All'
                                  ?  Text(AppLocalizations.of(context)!.translate('month').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                  : Text(
                                cubit.monthDropDown,
                                style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                              ),
                              underline: Container(),
                              isExpanded: true,
                              icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                              iconSize: 20.0,
                              style: const TextStyle(color: Colors.white , fontSize: 16.0 , fontWeight: FontWeight.bold),
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
                                cubit.usersFilterion(
                                    government: cubit.governmentDropDown,
                                    month: cubit.monthDropDown,
                                    year: cubit.yearDropDown,
                                    package: cubit.packageDropDown,
                                    skill: AppCubit.get(context).skillsDropDown

                                );
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
                              hint:cubit.yearDropDown =='All'
                                  ?  Text(AppLocalizations.of(context)!.translate('year').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                                  : Text(
                                cubit.yearDropDown,
                                style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                              ),
                              underline: Container(),
                              isExpanded: true,
                              icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                              iconSize: 20.0,
                              style: const TextStyle(color: Colors.white , fontSize: 16.0 , fontWeight: FontWeight.bold),
                              items: yearNames.map(
                                    (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                cubit.changeYearDropDown(value);
                                cubit.usersFilterion(
                                    government: cubit.governmentDropDown,
                                    month: cubit.monthDropDown,
                                    year: cubit.yearDropDown,
                                    package: cubit.packageDropDown,
                                    skill: AppCubit.get(context).skillsDropDown

                                );
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
                          hint:cubit.packageDropDown =='All'
                              ?  Text(AppLocalizations.of(context)!.translate('package').toString(), style: textManager(color: Colors.black,fontSize: SizeConfig.height*.022))
                              : Text(
                            cubit.packageDropDown,
                            style:textManager(color: Colors.black,fontSize: SizeConfig.height*.022),
                          ),
                          underline: Container(),
                          isExpanded: true,
                          icon: Icon(IconBroken.Arrow___Down_2,color: ColorManager.black,),
                          iconSize: 20.0,
                          style: const TextStyle(color: Colors.white , fontSize: 16.0 , fontWeight: FontWeight.bold),
                          items: packageNames.map(
                                (value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            cubit.changePackageDropDown(value);
                            cubit.usersFilterion(
                                government: cubit.governmentDropDown,
                                month: cubit.monthDropDown,
                                year: cubit.yearDropDown,
                                package: cubit.packageDropDown,
                                skill: AppCubit.get(context).skillsDropDown
                            );
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: SizeConfig.height*.02,),
                  ],
                ),

                SizedBox(height: SizeConfig.height*.02,),
                 Expanded(
                   child: ListView.separated(
                       itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: (){
                              navigateTo(context,  SingleUser(userModel: cubit.filterUsers[index],));
                            },
                            child: UserItem(
                              userModel: cubit.filterUsers[index],
                            ),
                          );
                       },
                       separatorBuilder: (context,index){
                         return SizedBox(height: SizeConfig.height*.02,);
                       },
                       itemCount: cubit.filterUsers.length
                   ),
                 ),
              ],
            ):
            const NotUsersYet()
          ),
        );
      },
    );
  }
}
