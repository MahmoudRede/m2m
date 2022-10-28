import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/model/upload_task_model.dart';
import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/widget/task_item_widget.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';

class ViewTasksScreen extends StatelessWidget {
  final String uId;
  const ViewTasksScreen({Key? key, required this.uId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>TasksCubit()..getUsersUploadedTasks(userId: uId),
      child: BlocConsumer<TasksCubit,TasksStates>(
        listener: (context, state){},
        builder: (context, state){

          var cubit = TasksCubit.get(context);
          List<UploadTaskModel> userTask = cubit.userUploadedTasks;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.translate('userTasks').toString(),
                style: TextStyle(
                  fontSize: SizeConfig.headline2Size,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: state is GetUserUploadedTaskSuccessState? ListView.separated(
                    itemBuilder: (context,index){
                      return TaskViewWidget(index: index, taskModel: userTask[index],);
                    },
                    separatorBuilder: (context,index)=>Container(),
                    itemCount: userTask.length,
                  ): const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
