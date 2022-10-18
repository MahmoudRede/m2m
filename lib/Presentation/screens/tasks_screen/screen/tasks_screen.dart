import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/custom_task_row.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/task_divider.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/tasks_custom_appbar.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/task_welcome_card.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit()..getUser(),
      child: BlocConsumer<TasksCubit,TasksStates>(
        listener: (context,state){},
        builder: (context,state){
          return state is GetUserLoadingState? Container(
            color: ColorManager.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorManager.secondDarkColor,
              ),
            ),
          ): Scaffold(
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
                          const TaskWelcomeCard(),
                          SizedBox(
                            height: SizeConfig.height *0.01,
                          ),
                          /// Tasks Title
                          const TaskDivider(),
                          /// Tasks List
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context , index)=>  CustomTaskRow(title: 'Your first Task', description: 'Like this page in facebook', index: '${index+1}'),
                            separatorBuilder: (context , index)=> SizedBox(
                              height: SizeConfig.height *0.05,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal :SizeConfig.height *0.03,
                                ),
                                child: Divider(
                                  color: ColorManager.black,
                                ),
                              ),
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
        },
      ),
    );
  }
}
