import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/screen/on_boarding_screen.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class PageViewItem extends StatelessWidget {
  int index;
  PageViewItem({Key? key,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List onBoardingScreens=[
      onBoardingModel(
          title: 'Freelancer',
          content: 'A freelancer is a self-employed individual who offers services to clients on a project basis, often working remotely and managing their own business',
          image: AssetsManager.onBoarding1
      ),
      onBoardingModel(
          title: 'Investment',
          content: 'We ate constantly adding your favourite restaurant throughout the territory and around your area carefully selected',
          image: AssetsManager.onBoarding2
      ),
      onBoardingModel(
          title: 'Social Media',
          content: ' it is easy to determine the exact number of calories consumed at each meal',
          image: AssetsManager.onBoarding5
      ),

    ];
    Size size =MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox( height: size.height*.05),
        Align(
          alignment: Alignment.center,
          child: Lottie.asset(
              onBoardingScreens[index].image,
              height: size.height*.35

          ),
        ),
        SizedBox( height: size.height*.05),
        Text(
          onBoardingScreens[index].title,
          style: GoogleFonts.aBeeZee(
              color: ColorManager.black,
              fontSize: size.height*.035,
              fontWeight: FontWeight.w600
          ),
        ),
        const SizedBox(height: 15,),
        Text(
          onBoardingScreens[index].content,
          style: textManager(
            color: ColorManager.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
