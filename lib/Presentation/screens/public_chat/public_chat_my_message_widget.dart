import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';


class MyMessagePublicChatWidget extends StatelessWidget {

  final int ?index;
  const MyMessagePublicChatWidget({Key? key,required this.index}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);

        return Align(
          alignment:Alignment.topRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              // message and user name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(SizeConfig.height*.02),
                        topLeft: Radius.circular(SizeConfig.height*.02),
                        bottomLeft: Radius.circular(SizeConfig.height*.02),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // user name
                          Text(cubit.userModel!.username,
                            style:textManager(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.height*.01,
                                color: ColorManager.white,
                            ),
                          ),

                          SizedBox(height: SizeConfig.height*.01,),

                          // message
                          Text('${AppCubit.get(context).publicChat[index!].text}',
                            style:textManager(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.height*.02,
                                color: ColorManager.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(width: SizeConfig.height*.01,),

              // user image
              CircleAvatar(
                radius: SizeConfig.height*.025,
                backgroundColor:  ColorManager.black,
                child: CircleAvatar(
                  backgroundImage:NetworkImage(AppCubit.get(context).userModel!.profileImage),
                  radius: SizeConfig.height*.024,
                  backgroundColor: Colors.black,
                ),

              ),

            ],
          ),
        );
      },
    );
  }
}
