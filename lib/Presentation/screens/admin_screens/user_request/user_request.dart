import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/admin_screens/user_request/widget/user_request_item.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/item/waiting_screen_item.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class UserRequest extends StatefulWidget {
  const UserRequest({Key? key}) : super(key: key);

  @override
  State<UserRequest> createState() => _UserRequestState();
}

class _UserRequestState extends State<UserRequest> {

  @override
  void initState() {
    super.initState();

    AppCubit.get(context).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: cubit.unConfirmedUsers.isNotEmpty?

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SizedBox(height: SizeConfig.height*.04,),

                  // user request item
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                        return UserRequestItem(
                          userName: cubit.unConfirmedUsers[index].username,
                          email: cubit.unConfirmedUsers[index].email,
                          government: cubit.unConfirmedUsers[index].government,
                          phone: cubit.unConfirmedUsers[index].phone,
                          personalImage: cubit.unConfirmedUsers[index].personalImage,
                          nationalCard: cubit.unConfirmedUsers[index].nationalIdImage,
                          userId: cubit.unConfirmedUsers[index].uId,
                        );
                      },
                      separatorBuilder: (context,index){
                        return SizedBox(height: SizeConfig.height*.0,);
                      },
                      itemCount: cubit.unConfirmedUsers.length,
                  ),

                ],
              ),
            ):

            const WaitingScreenItem(image:'assets/images/support.json', title: 'notFoundAnyRequestsYet')

          ),
        );

      },
    );
  }
}
