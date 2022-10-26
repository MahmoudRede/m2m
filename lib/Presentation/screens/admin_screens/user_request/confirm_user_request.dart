import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class ConfirmUserRequest extends StatelessWidget {


  const ConfirmUserRequest({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit= AppCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text('Complete Registration',style: GoogleFonts.aBeeZee(
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
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ColorManager.primary,
                        ),
                        image: const DecorationImage(
                            image: AssetImage(AssetsManager.idCard),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                ),
                SizedBox(height: size.height*.04,),
                Expanded(
                  flex: 1,
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: ColorManager.primary,
                        ),
                        image:const DecorationImage(
                            image: AssetImage(AssetsManager.selife),
                            fit: BoxFit.cover

                        )
                    ),
                  ),
                ),
                SizedBox(height: size.height*.05,),

                Row(
                  children: [

                    Expanded(
                      child: DefaultButton(
                          text: 'Accept',
                          color: ColorManager.primary,
                          onPressed: (){

                          }
                      ),
                    ),

                    SizedBox(width: SizeConfig.height*.02,),

                    Expanded(
                      child: DefaultButton(
                          text: 'Refuse',
                          color: ColorManager.primary,
                          onPressed: (){

                          }
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),


        );
      },
    );
  }
}
