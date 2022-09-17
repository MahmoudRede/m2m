import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/CustomBoxInformation.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: SizeConfig.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: SizeConfig.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomActionButton(
                boxIcon: FontAwesomeIcons.chevronLeft,
                iconColor: ColorManager.white,
                backgroundColor: ColorManager.black,
              ),
            ),
            Expanded(
                child: Center(
                    child: Lottie.asset(AssetsManager.investmentImage),
                ),
            ),
            Container(
              height: SizeConfig.height * 0.5,
              width: SizeConfig.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: ColorManager.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "1st Package 200\$",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Deposite 200\$, 5 Tasks for each Task 1.2\$, total income for months 180\$. "
                          "\nIf you don\'t invite anyone after the first months the task rate become 0.2\$.",
                      style: TextStyle(
                        color: Color.fromARGB(141, 255, 255, 255),
                        height: 1.4,
                        fontSize: 15,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        CustomBoxInformation(
                            boxIcon: FontAwesomeIcons.calendarCheck,
                            label: "3 Months"),
                        CustomBoxInformation(
                            boxIcon: FontAwesomeIcons.clock,
                            label: "5 Tasks"),
                        CustomBoxInformation(
                            boxIcon: FontAwesomeIcons.star,
                            label: "1.2\$"),
                      ],
                    ),
                    SizedBox(
                        height: SizeConfig.height *0.05,
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        alignment: Alignment.center,
                        width: SizeConfig.width,
                        height: 50,
                        decoration: BoxDecoration(
                            color: ColorManager.lightBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Participate  \$200",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}