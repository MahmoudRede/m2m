import 'package:flutter/material.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/task_item_button.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/business_logic/app_localization.dart';

class CustomTaskRow extends StatelessWidget {
  const CustomTaskRow({
    Key? key,
    required this.title,
    required this.description,
    required this.index,
  }) : super(key: key);

  final String title;
  final String description;
  final String index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SizedBox(
        width: SizeConfig.width,
        child: Column(
          children: [
            //task title, count and icon
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.whiteDark,
                  ),
                  child: const Padding(
                    padding:  EdgeInsets.all(10.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage(AssetsManager.taskImage),
                    ),
                  ),
                ),
                SizedBox(
                    width: SizeConfig.height*0.02,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: SizeConfig.headline3Size,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                          height:SizeConfig.height*0.005,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(136, 110, 103, 103),
                            fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: ColorManager.secondDarkColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    index,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontFamily: "Roboto",
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: SizeConfig.height *0.02,
            ),
            // task info (type , time , state)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Type : ',
                      style: TextStyle(
                        fontSize: SizeConfig.headline3Size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Like',
                      style: TextStyle(
                        fontSize: SizeConfig.headline3Size,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.lightBlue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.height*0.02,
                ),
                Row(
                  children: [
                    Text(
                      'Time : ',
                      style: TextStyle(
                        fontSize: SizeConfig.headline3Size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '01:30:59',
                      style: TextStyle(
                        fontSize: SizeConfig.headline3Size,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.lightBlue,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: SizeConfig.height*0.02,
                ),
                Row(
                  children: [
                    Text(
                      'State : ',
                      style: TextStyle(
                        fontSize: SizeConfig.headline3Size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Done',
                      style: TextStyle(
                        fontSize: SizeConfig.headline3Size,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.lightBlue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height *0.02,
            ),
            // confirm and upload button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TaskItemButton(
                  text: AppLocalizations.of(context)!.translate('confirm').toString(),
                  onPressed: (){},
                ),
                TaskItemButton(
                  text: AppLocalizations.of(context)!.translate('upload').toString(),
                  onPressed: (){},
                  // color: ColorManager.lightBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}