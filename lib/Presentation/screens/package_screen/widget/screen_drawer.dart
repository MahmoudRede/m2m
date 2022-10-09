import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m2m/Presentation/screens/investment_screen/screen/investment_screen.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/drawer_row_item.dart';
import 'package:m2m/Presentation/screens/profile_screen/screen/profile_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: SizeConfig.width *0.7,
        color: ColorManager.white,
        child: Column(
          children: [
            // user data
            Container(
              height: SizeConfig.height*0.3,
              width: SizeConfig.width *0.7,
              decoration: const BoxDecoration(
                color: ColorManager.lightBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.height*0.05,
                  ),
                  // user image
                  SizedBox(
                    height: SizeConfig.height*0.11,
                    width: SizeConfig.height*0.11,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Material(
                          elevation: 5.0,
                          shadowColor: ColorManager.lightGrey,
                          borderRadius: BorderRadius.circular(500),
                          child: CircleAvatar(
                            backgroundColor: ColorManager.white,
                            radius: 42,
                          ),
                        ),
                        const CircleAvatar(
                          backgroundImage: AssetImage(AssetsManager.userImage),
                          radius: 40,
                        ),
                      ],
                    ),
                  ),


                  SizedBox(
                    height: SizeConfig.height*0.01,
                  ),

                  // user name
                  Text(
                    'Mohamed Mmdouh',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontSize: SizeConfig.headline2Size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.height*0.05,
            ),
            DrawerRowItem(
              title: 'Profile',
              icon: FontAwesomeIcons.user,
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileScreen())),
            ),
            SizedBox(
              height: SizeConfig.height*0.05,
            ),
            DrawerRowItem(
              title: 'Packages',
              icon: FontAwesomeIcons.moneyBill,
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const PackageScreen())),
            ),
            SizedBox(
              height: SizeConfig.height*0.05,
            ),
            DrawerRowItem(
              title: 'Investment',
              icon: FontAwesomeIcons.dollarSign,
              onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const InvestmentScreen())),
            ),
            SizedBox(
              height: SizeConfig.height*0.05,
            ),
            DrawerRowItem(
              title: 'Logout',
              icon: Icons.logout,
              onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
