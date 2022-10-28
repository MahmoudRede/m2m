import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/default_form_field.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class AddCourses extends StatelessWidget {

  const AddCourses({Key? key}) : super(key: key);

  static TextEditingController courseTitleController=TextEditingController();
  static TextEditingController courseLinkController=TextEditingController();

  static GlobalKey<FormState> formKey= GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){


        if(state is AddCourseSuccessState){
          customToast(title: 'Course Added Successfully', color: ColorManager.primary);
          AppCubit.get(context).courseImage=null;
          Navigator.pop(context);
        }

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('addCourse').toString(),
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

                      // course title
                      Text(
                        '${AppLocalizations.of(context)!.translate('title').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.01,),

                      // enter course title
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: courseTitleController,
                        hint: AppLocalizations.of(context)!.translate('enterCourseTitle').toString(),
                        validText: '${AppLocalizations.of(context)!.translate('pleaseEnter').toString()} ${AppLocalizations.of(context)!.translate('title').toString()}',
                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      // course link
                      Text(
                        '${AppLocalizations.of(context)!.translate('link').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.01,),

                      // Enter course link
                      DefaultFormField(
                        textInputType: TextInputType.text,
                        controller: courseLinkController,
                        hint: AppLocalizations.of(context)!.translate('enterCourseLink').toString(),
                        validText: '${AppLocalizations.of(context)!.translate('pleaseEnter').toString()} ${AppLocalizations.of(context)!.translate('link').toString()}',

                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      Text(
                        '${AppLocalizations.of(context)!.translate('courseImage').toString()} :',
                        style: GoogleFonts.roboto(
                          color: ColorManager.black,
                          fontSize: SizeConfig.height*.025,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.02,),

                      GestureDetector(
                        onTap: (){
                          cubit.getCourseImage();
                        },
                        child: Container(
                          height: SizeConfig.height*.4,
                          width: SizeConfig.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: ColorManager.primary,
                              ),
                              image:cubit.courseImage!=null? DecorationImage(
                                image:  FileImage(cubit.courseImage!) ,
                              ):const DecorationImage(
                                  image: AssetImage('assets/images/courseImage.jpg'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),

                      SizedBox(height: SizeConfig.height*.02,),


                      // add course
                      state is UploadCourseImageLoadingState?
                      const Center(
                        child: CircularProgressIndicator(),
                      ):
                      DefaultButton(
                        text: AppLocalizations.of(context)!.translate('addCourse').toString(),
                        onPressed: (){
                          if(formKey.currentState!.validate()){

                            if(cubit.courseImage !=null){

                              cubit.uploadCourseImage(
                                courseTitle: courseTitleController.text ,
                                courseLink: courseLinkController.text,
                              );

                            }
                            else{

                              customToast(title: 'Please,Add required image', color: ColorManager.red);

                            }


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
