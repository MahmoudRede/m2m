import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/view_courses/widget/course_item_widget.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class ViewCourses extends StatelessWidget {
  const ViewCourses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=AppCubit.get(context);
          return Scaffold(

            // title
              appBar: AppBar(
                backgroundColor: ColorManager.white,
                elevation: 0.0,
                title: Text(AppLocalizations.of(context)!.translate('recommendedCourses').toString(),
                  style: GoogleFonts.aBeeZee(
                      color: ColorManager.black,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.height*.027
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
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.height*.02,),

                  // list of courses
                  child: ListView.separated(
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                             cubit.toCourseLink(courseLink: cubit.coursesList[index].courseLink);
                          },
                          child: CourseItemWidget(
                            title: cubit.coursesList[index].courseTitle,
                            image: cubit.coursesList[index].courseImage,
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: SizeConfig.height*.02,);
                      },
                      itemCount: cubit.coursesList.length
                  ),

                ),
              )
          );
        },
    );
  }
}
