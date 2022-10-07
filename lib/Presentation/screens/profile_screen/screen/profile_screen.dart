import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m2m/Presentation/screens/profile_screen/widget/package_divider.dart';
import 'package:m2m/Presentation/screens/profile_screen/widget/package_info_card.dart';
import 'package:m2m/Presentation/screens/profile_screen/widget/user_info_card.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.black,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.headline2Size,
            color: ColorManager.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.height*0.02,
            ),
            // user information card
            const UserInfoTask(),
            SizedBox(
              height: SizeConfig.height*0.04,
            ),
            // package divider
            const PackageDivider(),
            SizedBox(
              height: SizeConfig.height*0.04,
            ),
            // package information card
            const PackageInfoCard(),

          ],
        ),
      ),
    );
  }
}
