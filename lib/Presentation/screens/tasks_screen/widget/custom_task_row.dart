import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Data/model/user_task.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/task_item_button.dart';
import 'package:m2m/Presentation/screens/upload_task_screen/add_task_image.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';

class CustomTaskRow extends StatelessWidget {
  const CustomTaskRow({
    Key? key,
    required this.userTaskModel,
    required this.index,
  }) : super(key: key);

  final UserTaskModel userTaskModel;
  final String index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context,state){},
      builder: (context,state){
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.height*0.025,
          ),
          child: SizedBox(
            width: SizeConfig.width,
            child: Column(
              children: [
                //task title, count and icon
                Row(
                  children: [
                    Container(
                      width: SizeConfig.height*0.06,
                      height: SizeConfig.height*0.06,
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
                            userTaskModel.taskDescription.toString(),
                            style: TextStyle(
                              fontSize: SizeConfig.headline3Size,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: SizeConfig.height*0.04,
                      height: SizeConfig.height*0.04,
                      decoration: BoxDecoration(
                        color: ColorManager.secondDarkColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        index,
                        style: TextStyle(
                          color: ColorManager.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Roboto",
                          fontSize: SizeConfig.headline3Size,
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
                          '${AppLocalizations.of(context)!.translate('type').toString()} : ',
                          style: TextStyle(
                            fontSize: SizeConfig.headline3Size,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userTaskModel.taskType.toString(),
                          style: TextStyle(
                            fontSize: SizeConfig.headline4Size,
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
                          '${AppLocalizations.of(context)!.translate('time').toString()} : ',
                          style: TextStyle(
                            fontSize: SizeConfig.headline3Size,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userTaskModel.taskTimer.toString(),
                          style: TextStyle(
                            fontSize: SizeConfig.headline4Size,
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
                          '${AppLocalizations.of(context)!.translate('state').toString()} : ',
                          style: TextStyle(
                            fontSize: SizeConfig.headline3Size,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userTaskModel.taskIsConfirmed==true?AppLocalizations.of(context)!.translate('done').toString():AppLocalizations.of(context)!.translate('notDone').toString(),
                          style: TextStyle(
                            fontSize: SizeConfig.headline4Size,
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
                    // confirm task button
                    TaskItemButton(
                      text: AppLocalizations.of(context)!.translate('confirm').toString(),
                      onPressed: ()=>TasksCubit.get(context).urlLunch(taskLink: 'https://www.facebook.com/profile.php?id=100013281158897'),
                    ),

                    // upload task button
                    TaskItemButton(
                      text: AppLocalizations.of(context)!.translate('upload').toString(),
                      onPressed: ()=>navigateAndRemove(context, AddTaskImageScreen(userTaskModel: userTaskModel,)),
                      // color: ColorManager.lightBlue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}