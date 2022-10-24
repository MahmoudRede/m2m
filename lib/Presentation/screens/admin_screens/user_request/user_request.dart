import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/admin_screens/user_request/confirm_user_request.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/widget/custom_title.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class UserRequest extends StatelessWidget {
  const UserRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: SizeConfig.height*.05,),

                  // title
                  const CustomTitle(),

                  SizedBox(height: SizeConfig.height*.04,),

                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: (){
                            navigateTo(context, const ConfirmUserRequest());
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.height*.02,
                              right: SizeConfig.height*.02,
                              bottom: SizeConfig.height*.02,
                            ),
                            child: Material(
                              elevation: 2,
                              color: ColorManager.primary.withOpacity(.7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: SizeConfig.height*.02,
                                  right: SizeConfig.height*.02,
                                  top: SizeConfig.height*.02,
                                  bottom: SizeConfig.height*.02,
                                ),

                                decoration: BoxDecoration(
                                  color: ColorManager.black.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                       children: [
                                         CircleAvatar(
                                           backgroundImage:const NetworkImage('https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=740&t=st=1666607282~exp=1666607882~hmac=c2d5e7d678d67c2e43919b2ef95e2a00d82246b7615497516faace3cee271ca8'),
                                           radius: SizeConfig.height*.03,
                                         ),
                                         SizedBox(width: SizeConfig.height*.01,),
                                         Expanded(
                                             child: Text('Mahmoud Reda Abdallah',
                                               style: textManager(color: Colors.white),
                                               overflow: TextOverflow.ellipsis,
                                             ),
                                         ),
                                       ],
                                     ),

                                    SizedBox(height: SizeConfig.height*.02,),
                                    Row(
                                      children: [
                                        Text('Email : ',
                                          style: textManager(color: ColorManager.primary),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        Expanded(
                                          child: Text('mahmoudreda123456789101112@gmail.com',
                                            style: textManager(color: Colors.white,fontSize: SizeConfig.height*.02),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: SizeConfig.height*.02,),
                                    Row(
                                      children: [
                                        Text('phone : ',
                                          style: textManager(color: ColorManager.primary),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        Expanded(
                                          child: Text('01277556432',
                                            style: textManager(color: Colors.white,fontSize: SizeConfig.height*.02),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: SizeConfig.height*.02,),
                                    Row(
                                      children: [
                                        Text('Government : ',
                                          style: textManager(color: ColorManager.primary),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        Expanded(
                                          child: Text('El-Bialystok',
                                            style: textManager(color: Colors.white,fontSize: SizeConfig.height*.02),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: SizeConfig.height*.02,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Skills :',
                                          style: textManager(color: ColorManager.primary),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        SizedBox(height: SizeConfig.height*.015,),

                                        Text('El-Bialystok',
                                          style: textManager(color: Colors.white,fontSize: SizeConfig.height*.02),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: SizeConfig.height*.0,);
                      },
                      itemCount: 10,
                  )
                ],
              ),
            ),
          ),
        );

      },
    );
  }
}
