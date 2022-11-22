import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';


class ResieverPublicChatWidget extends StatelessWidget {

  final int ?index;

   const ResieverPublicChatWidget({Key? key,required this.index}) : super(key: key);


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
            children: [

              // user image
              CircleAvatar(
                radius: SizeConfig.height*.025,
                backgroundColor: ColorManager.grey,
                child: CircleAvatar(
                  backgroundImage:NetworkImage('${cubit.publicChat[index!].senderImage}' ),
                  radius: SizeConfig.height*.024,
                  backgroundColor: Colors.blue,
                ),

              ),

              SizedBox(width: SizeConfig.height*.01,),


              Column(
                children: [

                  Container(
                    width: MediaQuery.of(context).size.width*.74,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5
                    ),
                    decoration:  BoxDecoration(
                      color:  Colors.black.withOpacity(.7),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(SizeConfig.height*.02),
                        topLeft: Radius.circular(SizeConfig.height*.02),
                        bottomRight: Radius.circular(SizeConfig.height*.02),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // user name
                          Text('${cubit.publicChat[index!].senderName}',
                            style:textManager(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.height*.01,
                              color: ColorManager.white,
                            ),

                          ),
                          SizedBox(height: SizeConfig.height*.01,),

                          // message
                          Text('${cubit.publicChat[index!].text}',
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
            ],
          ),
        );
      },
    );
  }
}
