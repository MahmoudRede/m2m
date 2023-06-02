import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/widget/custom_title.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/widget/pageview_item.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingModel{
  late final String title;
  late final String content;
  late final String image;

  onBoardingModel({
    required this.title,
    required this.content,
    required this.image,
  });

}

class OnBoarding extends StatefulWidget {

  OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var pageController=PageController();
  int currentIndex=1;
  late Timer timer;

  @override
  void initState() {

    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      Future.delayed(const Duration(seconds: 7),(){
        if(currentIndex==3){
          navigateAndRemove(context,const LoginScreen());
        }
        else{
          currentIndex++;
          pageController.nextPage(duration: const Duration(seconds: 3), curve: Curves.fastOutSlowIn);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.white
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 25
        ),
        child: Column(
          children: [
            const CustomTitle(),
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (val){

                },
                itemBuilder: (context,index){
                  return PageViewItem(index: index);
                },
                itemCount: 3 ,
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
              effect: JumpingDotEffect(
                  dotColor: ColorManager.grey,
                  activeDotColor: ColorManager.primary,
                  dotWidth: 12,
                  dotHeight: 12,
              ),

            ),
            SizedBox(height: size.height*.03,),
            DefaultButton(
              color: ColorManager.primary,
              text: 'Get Started',
              onPressed: (){

                navigateAndRemove(context,const LoginScreen());

              },
            ),
            SizedBox(height:size.height*.005,),
          ],
        ),
      ),
    );
  }
}