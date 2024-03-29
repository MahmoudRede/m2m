import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/more_screen/more_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/custom_package_card.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/package_slider_item.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/screen_drawer.dart';
import 'package:m2m/Presentation/screens/tasks_screen/screen/tasks_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class PackageScreenItem extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final List<String> packageTitle = [
    '1st Package 200\$',
    '2nd Package 350\$',
    '3th Package 650\$',
  ];

  final List<String> packageTasks = [
    '5',
    '7',
    '10',
  ];

  final List<String> packageImage = [
    AssetsManager.firstPackageImage,
    AssetsManager.secondPackageImage,
    AssetsManager.thirdPackageImage,
  ];

  final List carouselImage = [
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
  ];
    PackageScreenItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener:(context,state){},
      builder:(context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Screen Custom Appbar
              SizedBox(
                height: SizeConfig.topPadding,
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal:SizeConfig.height*0.03,
                  vertical: SizeConfig.height*0.01,
                ),
                child: Row(
                  children: [
                    CustomActionButton(
                      backgroundColor: ColorManager.primary,
                      boxIcon: FontAwesomeIcons.bars,
                      iconColor: ColorManager.white,
                      onTap: ()=> navigateTo(context,const MoreScreen()),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height*.1,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('M ',style: GoogleFonts.bungee(
                              color: ColorManager.black,
                              fontSize: SizeConfig.height*.045,
                              fontWeight: FontWeight.bold
                          ),),
                          Text('2',style: GoogleFonts.bungee(
                              color: ColorManager.primary,
                              fontSize: SizeConfig.height*.05,
                              fontWeight: FontWeight.bold
                          ),),
                          Text(' M',style: GoogleFonts.bungee(
                              color: ColorManager.black,
                              fontSize: SizeConfig.height*.045,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: SizeConfig.height*0.02,
                      ),
                      /// screen slider

                      SizedBox(
                        width: SizeConfig.width ,
                        height: SizeConfig.height*0.2,
                        child: CarouselSlider.builder(
                            itemCount: cubit.coursesList.length,
                            itemBuilder: (BuildContext context, int index, int pageViewIndex) => GestureDetector(
                              onTap: (){
                                cubit.toCourseLink(courseLink: cubit.coursesList[index].courseLink);
                              },
                              child: PackageSliderItem(
                                title: cubit.coursesList[index].courseTitle,
                                image: cubit.coursesList[index].courseImage,
                              ),
                            ),
                            options: CarouselOptions(
                              height: SizeConfig.height*0.2,
                              aspectRatio: 16/9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            )
                        ),
                      ),


                      SizedBox(
                        height: SizeConfig.height*0.03,
                      ),

                      // package title
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.height*0.03,
                          vertical: SizeConfig.height*0.01,
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.translate('packages').toString(),
                          style: GoogleFonts.roboto(
                            color: ColorManager.black,
                            fontSize: SizeConfig.headline1Size,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),


                      /// Packages Card List
                      Padding(
                        padding : EdgeInsets.symmetric(
                          horizontal: SizeConfig.height*0.01,
                        ),
                        child: SizedBox(
                          height: SizeConfig.height * 0.55,
                          width: SizeConfig.width,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context , index) => CustomPackageCard(
                              image: packageImage[index],
                              title: packageTitle[index],
                              tasksNum: packageTasks[index],
                            ),
                            separatorBuilder: (context , index) => Container(),
                            itemCount: packageTitle.length,
                          ),
                        ),
                      ),

                      /// View tasks Button
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.height*0.01,
                          vertical: SizeConfig.height*0.02,
                        ),
                        child: DefaultButton(
                          text: AppLocalizations.of(context)!.translate('viewTasks').toString(),
                          onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const TasksScreen())),
                          color: ColorManager.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );


      },
    );
  }
}
