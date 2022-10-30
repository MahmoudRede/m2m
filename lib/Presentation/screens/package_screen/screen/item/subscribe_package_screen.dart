import 'package:carousel_slider/carousel_slider.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/package_slider_item.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/screen_drawer.dart';
import 'package:m2m/Presentation/screens/tasks_screen/screen/tasks_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/payment_cubit/payment_cubit.dart';
import 'package:m2m/business_logic/payment_cubit/payment_states.dart';

class SubscribePackageScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final List carouselImage = [
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
    'https://img.freepik.com/free-vector/hand-drawn-colorful-space-background_52683-12648.jpg',
  ];

  SubscribePackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> PaymentCubit()..getUser(),
      child: BlocConsumer<PaymentCubit,PaymentStates>(
        listener: (context,state){},
        builder: (context,state){
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
                              itemCount: carouselImage.length,
                              itemBuilder: (BuildContext context, int index, int pageViewIndex) => PackageSliderItem(
                                title: "Title",
                                image: carouselImage[index],
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


                        // graph widget


                        /// View tasks Button
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.height*0.01,
                            vertical: SizeConfig.height*0.02,
                          ),
                          child: DefaultButton(
                            text: AppLocalizations.of(context)!.translate('viewTasks').toString(),
                            onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const TasksScreen())),
                            color: ColorManager.secondDarkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            drawer: const HomeDrawer(),
          );
        },
      ),
    );
  }
}
