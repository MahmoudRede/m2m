import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/home_screen/widget/custom_investment_row.dart';
import 'package:m2m/Presentation/screens/home_screen/widget/custom_package_card.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
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

    return Scaffold(
        body: Container(
          width: SizeConfig.width,
          height: SizeConfig.height,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: SizeConfig.height * 0.04,
              ),
              /// Screen Custom Appbar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CustomActionButton(
                      backgroundColor: ColorManager.SecondDarkColor,
                      boxIcon: FontAwesomeIcons.bars,
                      iconColor: const Color.fromARGB(255, 245, 238, 238),
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
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Packages",
                  style: GoogleFonts.aBeeZee(
                    color: ColorManager.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              /// Packages Card List
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
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
              SizedBox(
                height: SizeConfig.height*0.008,
              ),
              /// Investment Title and more button
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      "Investment Department",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black),
                    ),
                    Spacer(),
                    Text(
                      "More",
                      style:
                      textManager(
                          fontSize: 14,
                          color: ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                  height: 10,
              ),
              /// Investment Information Row
              const CustomInvestmentRow(
                title: 'Investment for 6 months',
                description: '10% profit for each months ,total Capital will return 25%',
                profit: '10%',
              ),
            ],
          ),
        ));
  }
}



