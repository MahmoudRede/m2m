import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/register_screen/screen/follow_register/follow_register.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/register_cubit/register_cubit.dart';
import 'package:m2m/business_logic/register_cubit/register_state.dart';

class PersonalImage extends StatelessWidget {

  const PersonalImage({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit,RegisterState>(
      listener: (context,state){

        if(state is UploadPersonalImageSuccessState){

          Navigator.pop(context);

        }

        if(state is UploadPersonalImageErrorState){

          customToast(title: 'Error in Something ,Please try again', color: ColorManager.red);

        }


      },
      builder: (context,state){
        var cubit= RegisterCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text('Personal Image',style: GoogleFonts.aBeeZee(
                color: ColorManager.black,
                fontWeight: FontWeight.w500,
                fontSize: size.height*.03
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
            backwardsCompatibility: false,
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
            ),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.height*.02,),
                Container(
                  height: size.height*.6,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ColorManager.primary,
                      ),
                      image:cubit.uploadedPersonalImage!=null? DecorationImage(
                        image:  FileImage(cubit.uploadedPersonalImage!) ,
                      ):const DecorationImage(
                          image: AssetImage(AssetsManager.selife),
                          fit: BoxFit.cover

                      )
                  ),
                ),
                const Spacer(),
                state is UploadPersonalImageLoadingState ?
                const Align(
                  alignment: Alignment.topRight,
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                ):
                Align(
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    backgroundColor: ColorManager.primary,
                    onPressed: (){
                      cubit.uploadPersonalImage();
                    },
                    child: const Icon(
                        IconBroken.Arrow___Right_2
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.height*.02,)

              ],
            ),
          ),

        );
      },
    );
  }
}
