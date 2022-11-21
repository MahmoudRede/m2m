import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/custom_task_row.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/task_divider.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/tasks_custom_appbar.dart';
import 'package:m2m/Presentation/screens/tasks_screen/widget/task_welcome_card.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_localization.dart';
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
          var cubit = TasksCubit.get(context);
          return state is GetUserLoadingState? Container(
            color: ColorManager.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorManager.secondDarkColor,
              ),
            ),
          ): Scaffold(
            body: cubit.userModel!.package.isVerified==true? Container(
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
                          cubit.todayTasks.isNotEmpty?ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context , index)=>  CustomTaskRow(userTaskModel: cubit.todayTasks[index], index: '${index+1}'),
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
                            itemCount: cubit.todayTasks.length,
                          ):Container(
                            height: SizeConfig.height *0.4,
                            color: ColorManager.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.height*0.03,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: SizeConfig.height*0.3,
                                    child: Lottie.asset("assets/images/waiting.json"),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.height*0.02,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.translate('taskWaitMessage').toString(),
                                    style: GoogleFonts.roboto(
                                      fontSize: SizeConfig.headline3Size,
                                      color: ColorManager.secondDarkColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
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
            ):
            Container(
              height: SizeConfig.height,
              color: ColorManager.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.height*0.03,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/images/waiting.json"),
                    SizedBox(
                      height: SizeConfig.height*0.02,
                    ),
                    Text(
                      AppLocalizations.of(context)!.translate('noSubscribeAndWaitingTaskMessage').toString(),
                      style: GoogleFonts.roboto(
                        fontSize: SizeConfig.headline3Size,
                        color: ColorManager.secondDarkColor,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.height*0.1,
                    ),
                    DefaultButton(
                      text: AppLocalizations.of(context)!.translate('backToHome').toString(),
                      onPressed: ()=>navigateAndRemove(context, const PackageScreen()),
                      color: ColorManager.secondDarkColor,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
