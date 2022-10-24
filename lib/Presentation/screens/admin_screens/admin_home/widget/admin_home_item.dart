import 'package:flutter/material.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_localization.dart';

class AdminHomeItem extends StatelessWidget {
  static List titleName=[
    'all_users',
    'payment_screens',
    'add_tasks',
    'users_request',
  ];

  static List imageName=[
    'all_users',
    'payment_screens',
    'add_task',
    'request_users',
  ];

  final int index;
  final VoidCallback onTap;
  const AdminHomeItem({Key? key,required this.index, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        height: SizeConfig.height*.14,
        padding: EdgeInsets.all(
          SizeConfig.height*.02,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.height*.02,
        ),
        decoration: BoxDecoration(
            border: Border.all(
                color: ColorManager.primary
            ),
            borderRadius: BorderRadius.circular(SizeConfig.height*.02),

            // image
            image: DecorationImage(
                image: AssetImage('assets/images/${imageName[index]}.jpg'),
                opacity: .5,
                fit: BoxFit.cover
            )
        ),
        // test
        child: Text(AppLocalizations.of(context)!.translate(titleName[index]).toString(),
          style: textManager(
              color: ColorManager.black,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.height*.03
          ),
        ),


      ),
    );
  }
}
