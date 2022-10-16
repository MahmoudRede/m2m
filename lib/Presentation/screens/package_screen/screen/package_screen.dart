import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/custom_package_card.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/package_slider_item.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/screen_drawer.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/business_logic/app_localization.dart';


class PackageScreen extends StatelessWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    List<String> packageTitle = [
      '1st Package 200\$',
      '2nd Package 350\$',
      '3th Package 650\$',
      'VIP Package 3000\$',
      'VIP+ Package 5000\$',
    ];

    List<String> packageTasks = [
      '5 Tasks',
      '7 Tasks',
      '10 Tasks',
      '20 Tasks',
      '40 Tasks',
    ];

    List<String> packageImage = [
      AssetsManager.firstPackageImage,
      AssetsManager.secondPackageImage,
      AssetsManager.thirdPackageImage,
      AssetsManager.investmentImage,
      AssetsManager.investmentImage,
    ];

    List carouselImage = [
      'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
      'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
      'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
      'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
    ];

    return Scaffold(
      key: scaffoldKey,
      body: Container(
          width: SizeConfig.width,
          height: SizeConfig.height,
          color: Colors.white,
          child: Column(
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
                      backgroundColor: ColorManager.secondDarkColor,
                      boxIcon: FontAwesomeIcons.bars,
                      iconColor: ColorManager.white,
                      onTap: ()=> scaffoldKey.currentState!.openDrawer(),
                    ),
                    Expanded(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.height*0.02,
              ),


              /// screen slider
              SizedBox(
                width: MediaQuery.of(context).size.width *1,
                height: SizeConfig.height*0.15,
                child: CarouselSlider.builder(
                    itemCount: carouselImage.length,
                    itemBuilder: (BuildContext context, int index, int pageViewIndex) => PackageSliderItem(
                      title: "Title",
                      image: carouselImage[index],
                    ),
                    options: CarouselOptions(
                      height: SizeConfig.height*0.15,
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
                height: SizeConfig.height*0.02,
              ),


              // package title
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.height*0.03,
                  vertical: SizeConfig.height*0.01,
                ),
                child: Text(
                AppLocalizations.of(context)!.translate('packages').toString(),
                  style: GoogleFonts.aBeeZee(
                    color: ColorManager.black,
                    fontSize: 32,
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
                  height: SizeConfig.height * 0.5,
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
                  onPressed: (){},
                  color: ColorManager.secondDarkColor,
                ),
              ),
            ],
          ),
        ),
      drawer: const HomeDrawer(),
    );
  }
}



