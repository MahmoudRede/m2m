import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class PackageInfoCard extends StatelessWidget {
  const PackageInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height*0.2,
      width: SizeConfig.width*0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.secondDarkColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(
          SizeConfig.height*0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'First Package 300\$',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.headline2Size,
                  color: ColorManager.white,
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.height*0.03,
            ),
            Row(
              children: [
                Text(
                  'Start Date : ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  DateFormat('dd / MM / yyyy').format(DateTime.now()).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height*0.0012,
            ),
            Row(
              children: [
                Text(
                  'End Date : ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  DateFormat('dd / MM / yyyy').format(DateTime.now()).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height*0.0012,
            ),
            Row(
              children: [
                Text(
                  'Today Tasks : ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  '5',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height*0.0012,
            ),
            Row(
              children: [
                Text(
                  'Task profit : ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  '1.2\$',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height*0.0012,
            ),
            Row(
              children: [
                Text(
                  'Months profit : ',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
                Text(
                  '180\$',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: SizeConfig.headline4Size,
                    color: ColorManager.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
