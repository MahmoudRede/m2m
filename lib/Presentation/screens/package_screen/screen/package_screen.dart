import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/item/package_screen_item.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/item/waiting_screen_item.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';


class PackageScreen extends StatelessWidget {
  const PackageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
            var cubit=AppCubit.get(context);
            return cubit.userModel!=null?
                cubit.userModel!.isConfirmed==false?
                    
                // Main Widget
                PackageScreenItem():
                
                // Waiting Widget    
                const WaitingScreenItem()
            
                :const Center(child: CircularProgressIndicator(),
            );
        },
    );
  }
}



