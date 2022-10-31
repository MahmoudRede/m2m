import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/item/package_screen_item.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/item/subscribe_package_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/item/waiting_screen_item.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/payment_cubit/payment_cubit.dart';


class PackageScreen extends StatefulWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {

  @override
  void initState(){
    super.initState();
    debugPrint("==================================token================================");
    AppCubit.get(context).getToken();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppCubit.get(context);

        return cubit.userModel!=null?
        cubit.userModel!.isConfirmed==true?

        // Main Widget
        cubit.userModel!.package.isVerified==true?SubscribePackageScreen():PackageScreenItem() :

        // Waiting Widget
        const WaitingScreenItem(
          image: 'assets/images/waiting_image.json',
          title: 'waiting',
        )

            :const Scaffold(body:Center(child: CircularProgressIndicator(),)
        );
      },
    );
  }
}
