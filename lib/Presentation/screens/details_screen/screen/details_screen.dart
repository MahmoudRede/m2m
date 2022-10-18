import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/tasks_screen/screen/tasks_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/CustomBoxInformation.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
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
              padding: const EdgeInsets.all(25.0),
              child: CustomActionButton(
                boxIcon: FontAwesomeIcons.chevronLeft,
                iconColor: ColorManager.white,
                backgroundColor: ColorManager.secondDarkColor,
                onTap: ()=>  Navigator.pop(context),
              ),
            ),
            Expanded(
                child: Center(
                    child: Lottie.asset(AssetsManager.investmentImage),
                ),
            ),
            Container(
              height: SizeConfig.height * 0.55,
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
                    Text(
                      "1st Package 200\$",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                     Text(
                      "Deposite 200\$, 5 Tasks for each Task 1.2\$, total income for months 180\$. "
                          "\nIf you don\'t invite anyone after the first months the task rate become 0.2\$.",
                      style: GoogleFonts.roboto(
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
                    DefaultButton(text: 'Participate  \$200', onPressed: (){
                      navigateTo( context,TasksScreen());
                    }),
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