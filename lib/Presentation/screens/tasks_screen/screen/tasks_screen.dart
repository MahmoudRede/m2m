import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/custom_task_row.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/task_divider.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/tasks_custom_appbar.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/welcome_card.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: SizeConfig.width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TasksCustomAppbar(),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.height* 0.01,
                    ),
                    const WelcomeCard(),
                    SizedBox(
                      height: SizeConfig.height *0.01,
                    ),
                    /// Tasks Title
                    const TaskDivider(),
                    /// Tasks List
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context , index)=> const CustomTaskRow(title: 'Your first Task', description: 'Like this page in facebook', profit: '20'),
                        separatorBuilder: (context , index)=> SizedBox(
                          height: SizeConfig.height *0.05,
                        ),
                        itemCount: 5,
                    ),
                    SizedBox(
                      height: SizeConfig.height *0.05,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
