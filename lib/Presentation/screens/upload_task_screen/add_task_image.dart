import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/upload_task_screen/upload_task_images.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';

class AddTaskImageScreen extends StatelessWidget {
  const AddTaskImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit,TasksStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = TasksCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add task image',
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

                // add task from gallery
                InkWell(
                  onTap: ()=>cubit.getTaskImage(),
                  child: Container(
                    height: SizeConfig.height*0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: ColorManager.secondDarkColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: ColorManager.white,
                    ),
                    child: cubit.uploadedTaskImage == null ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Icon(
                          Icons.image_outlined,
                          color: ColorManager.lightBlue,
                          size: SizeConfig.height*0.05,
                        ),
                        Text(
                          'Choose image',
                          style: TextStyle(
                            fontSize: SizeConfig.headline4Size,
                            color: ColorManager.lightBlue,
                          ),
                        ),
                      ],
                    ) :
                    Material(
                      borderRadius: BorderRadius.circular(10),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image(
                        image: FileImage(cubit.uploadedTaskImage!),
                        fit: BoxFit.fill,
                        height: double.maxFinite,
                        width: double.maxFinite,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height*0.05,
                ),

                // upload button
                state is UploadTaskImageLoadingState?
                const CircularProgressIndicator(
                  color: ColorManager.primary,
                ):DefaultButton(
                  text: AppLocalizations.of(context)!.translate('add').toString(),
                  onPressed: (){
                    if(cubit.uploadedTaskImage != null){
                      cubit.uploadTaskImage().then((value) async{
                        await customToast(title: 'image is uploaded', color: ColorManager.gold);
                        cubit.uploadedTaskImage = null;
                        await navigateAndRemove(context, const UploadTaskImagesScreen());
                      });
                    }else{
                      customToast(title: 'please select image', color: ColorManager.red);
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
