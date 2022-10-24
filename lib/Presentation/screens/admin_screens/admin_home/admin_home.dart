import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/admin_screens/admin_home/widget/admin_home_item.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/widget/custom_title.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class AdminHome extends StatelessWidget {

  const AdminHome({Key? key}) : super(key: key);

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
                children: [

                  SizedBox(height: SizeConfig.height*.05,),

                  // title
                  const CustomTitle(),

                  SizedBox(height: SizeConfig.height*.06,),

                  // list of features
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return AdminHomeItem(index: index,);
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: SizeConfig.height*.03,);
                      },
                      itemCount: 4
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