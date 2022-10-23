import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';

class TasksCustomAppbar extends StatelessWidget {
  const TasksCustomAppbar({
    // required this.title,
    // required this.userImage,
    Key? key}) : super(key: key);

  // final String title;
  // final String userImage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit , TasksStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = TasksCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.topPadding,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.height*0.01,
                vertical: SizeConfig.height*0.01,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.height*0.02,),
                    child: CustomActionButton(
                      boxIcon: FontAwesomeIcons.chevronLeft,
                      iconColor: ColorManager.white,
                      backgroundColor: ColorManager.secondDarkColor,
                      onTap: ()=>  Navigator.pop(context),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: TextStyle(
                            fontSize: SizeConfig.headline3Size,
                            color: ColorManager.lightGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          cubit.userModel!.username.toString(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: SizeConfig.headline2Size,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  cubit.userModel!.personalImage != null? CircleAvatar(
                    radius: SizeConfig.width *0.075,
                    backgroundImage: NetworkImage(
                      cubit.userModel!.personalImage.toString(),
                    ),
                  ):CircleAvatar(
                    radius: SizeConfig.width *0.08,
                    backgroundImage:  const AssetImage(
                      AssetsManager.userImage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
