import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/admin_screens/filter_users/filter_users.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class AddTasks extends StatelessWidget {

  const AddTasks({Key? key}) : super(key: key);

  static TextEditingController taskUrlController=TextEditingController();
  static TextEditingController taskDescriptionController=TextEditingController();
  static TextEditingController taskTypeController=TextEditingController();
  static TextEditingController taskTimerController=TextEditingController();
  static TextEditingController taskPriceController=TextEditingController();

  static GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){

        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('add_tasks').toString(),
              style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.height*.03
              ),),
            titleSpacing: 0,
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: ColorManager.black,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
            ),
          ),

          body: SafeArea(
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.height*.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: SizeConfig.height*.01,),

                      // title
                      Text(
                        '${AppLocalizations.of(context)!.translate('url').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.01,),

                      // enter task url
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskUrlController,
                        hint: AppLocalizations.of(context)!.translate('enterTaskUrl').toString(),
                        validText: '${AppLocalizations.of(context)!.translate('pleaseEnter').toString()} ${AppLocalizations.of(context)!.translate('url').toString()}',
                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      // Description
                      Text(
                        '${AppLocalizations.of(context)!.translate('description').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.01,),

                      // enter task Description
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskDescriptionController,
                        hint: AppLocalizations.of(context)!.translate('enterTaskDescription').toString(),
                        maxLines: 5,
                        validText: '${AppLocalizations.of(context)!.translate('pleaseEnter').toString()} ${AppLocalizations.of(context)!.translate('description').toString()}',

                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      // Type
                      Text(
                        '${AppLocalizations.of(context)!.translate('type').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.01,),

                      // Enter task type
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskTypeController,
                        hint: AppLocalizations.of(context)!.translate('enterTaskType').toString(),
                        validText: '${AppLocalizations.of(context)!.translate('pleaseEnter').toString()} ${AppLocalizations.of(context)!.translate('type').toString()}',

                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      // timer
                      Text(
                        '${AppLocalizations.of(context)!.translate('timer').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.01,),

                      // Enter task timer
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskTimerController,
                        hint: AppLocalizations.of(context)!.translate('enterTaskTimer').toString(),
                        validText: '${AppLocalizations.of(context)!.translate('pleaseEnter').toString()} ${AppLocalizations.of(context)!.translate('timer').toString()}',

                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      // price
                      Text(
                        '${AppLocalizations.of(context)!.translate('price').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.01,),

                      // Enter task price
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: taskPriceController,
                        hint: AppLocalizations.of(context)!.translate('enterTaskPrice').toString(),
                        validText: '${AppLocalizations.of(context)!.translate('pleaseEnter').toString()} ${AppLocalizations.of(context)!.translate('price').toString()}',

                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      // send task
                      DefaultButton(
                        text: AppLocalizations.of(context)!.translate('send_task').toString(),
                        onPressed: (){
                            if(formKey.currentState!.validate()){

                              AppCubit.get(context).isUserSelected = List.generate(250, (index) => false);
                              AppCubit.get(context).selectAll=false;
                              AppCubit.get(context).usersId=[];
                              navigateTo(context,SelectUsers(
                                taskUrl: taskUrlController.text,
                                taskDescription: taskDescriptionController.text,
                                taskType: taskTypeController.text,
                                taskTimer: taskTimerController.text,
                                taskPrice: taskPriceController.text,
                              ));

                            }
                        },

                      ),

                      SizedBox(height: SizeConfig.height*.01,),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );

      },

    );
  }
}
