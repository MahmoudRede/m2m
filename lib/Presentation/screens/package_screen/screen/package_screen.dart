import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/item/package_screen_item.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/custom_package_card.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/package_slider_item.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/screen_drawer.dart';
import 'package:m2m/Presentation/screens/tasks_screen/screen/tasks_screen.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custome_action_button.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
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
        PackageScreenItem():const Center(
          child: CircularProgressIndicator(color: Colors.red),
        ):const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}



