import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Data/model/user_task.dart';
import 'package:m2m/Presentation/screens/tasks_screen/screen/tasks_screen.dart';
import 'package:m2m/Presentation/screens/upload_task_screen/add_task_image.dart';
import 'package:m2m/Presentation/screens/upload_task_screen/widget/grid_image_widget.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';

class UploadTaskImagesScreen extends StatelessWidget {
  final UserTaskModel userTaskModel;
  const UploadTaskImagesScreen({Key? key, required this.userTaskModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = TasksCubit.get(context);
        debugPrint("task Images ==> ${cubit.userTaskImages.toString()}");
        List <String> taskImages = cubit.userTaskImages;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.translate('uploadTaskImage').toString(),
              style: TextStyle(
                fontSize: SizeConfig.headline2Size,
                fontWeight: FontWeight.bold,
                color: ColorManager.black,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical :SizeConfig.height*0.02,
              horizontal :SizeConfig.height*0.03,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                // image grid view
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                      ),
                    itemBuilder: (context,index){
                        return GridImageWidget(image: taskImages[index],);
                      },
                    itemCount: taskImages.length,
                  ),
                ),


                // add image button
                DefaultButton(
                  text: AppLocalizations.of(context)!.translate('add').toString(),
                  onPressed: (){
                    navigateTo(context, AddTaskImageScreen(userTaskModel: userTaskModel,));
                  },
                  color: ColorManager.secondDarkColor,
                ),
                SizedBox(
                  height: SizeConfig.height*0.01,
                ),


                // upload task button
                state is UploadTaskLoadingState?
                const CircularProgressIndicator(
                  color: ColorManager.primary,
                ):DefaultButton(
                  text: AppLocalizations.of(context)!.translate('upload').toString(),
                  onPressed: (){
                    if(taskImages.isNotEmpty){
                      cubit.uploadTask(userTaskModel: userTaskModel,).then((value){
                        customToast(title: AppLocalizations.of(context)!.translate('taskIsUploaded').toString(), color: ColorManager.gold);
                        navigateAndRemove(context, const TasksScreen());
                      });
                    }else{
                      customToast(title: AppLocalizations.of(context)!.translate('pleaseSelectImage').toString(), color: ColorManager.red);
                    }
                  },
                  color: ColorManager.secondDarkColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}