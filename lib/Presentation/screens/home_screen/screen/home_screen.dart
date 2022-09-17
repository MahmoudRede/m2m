import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/home_screen/widget/custom_investment_row.dart';
import 'package:m2m/Presentation/screens/home_screen/widget/custom_package_card.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                    const Expanded(
                        child: Center(
                          child: Text(
                            'M2M',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height:  SizeConfig.height * 0.01,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Packages",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
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
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.black),
                    ),
                    const Expanded(
                        child: Text(""),
                    ),
                    Text(
                      "More",
                      style:
                      TextStyle(
                          fontSize: 14,
                          color: ColorManager.blue,
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



