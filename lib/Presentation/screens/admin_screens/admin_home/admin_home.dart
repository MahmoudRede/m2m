import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/admin_screens/add_courses/add_courses.dart';
import 'package:m2m/Presentation/screens/admin_screens/add_tasks/add_tasks.dart';
import 'package:m2m/Presentation/screens/admin_screens/admin_home/widget/admin_home_item.dart';
import 'package:m2m/Presentation/screens/admin_screens/all_users/all_users.dart';
import 'package:m2m/Presentation/screens/admin_screens/filter_users/filter_users.dart';
import 'package:m2m/Presentation/screens/admin_screens/filter_users/widget/filter_user_item.dart';
import 'package:m2m/Presentation/screens/admin_screens/payment_screens/payment_requests_screen.dart';
import 'package:m2m/Presentation/screens/admin_screens/user_request/user_request.dart';
import 'package:m2m/Presentation/screens/admin_screens/view_user_tasks/view_user_tasks.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/widget/custom_title.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class AdminHome extends StatelessWidget {

  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List onTaps = [
      ()=>navigateTo(context, const AllUser()),
      ()=>navigateTo(context, const PaymentRequestsScreen()),
      ()=>navigateTo(context, const AddTasks()),
      ()=>navigateTo(context, const ViewUserTasksScreen()),
      ()=>navigateTo(context, const UserRequest()),
      ()=>navigateTo(context, const AddCourses()),
    ];

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: Column(
            children: [
              SizedBox(height: SizeConfig.topPadding,),
              // title
              const CustomTitle(),

              SizedBox(height: SizeConfig.height*.03,),

              // list of features
              Expanded(
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index){
                      return AdminHomeItem(index: index, onTap: onTaps[index],);
                    },
                    separatorBuilder: (context,index){
                      return SizedBox(height: SizeConfig.height*.03,);
                    },
                    itemCount: onTaps.length,
                ),
              ),
              SizedBox(height: SizeConfig.height*.02,),
            ],
          ),
        );

        },
    );
  }
}
