import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/more_screen/more_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/widget/drawer_row_item.dart';
import 'package:m2m/Presentation/screens/profile_screen/screen/profile_screen.dart';
import 'package:m2m/Presentation/screens/public_chat/public_chat_screen.dart';
import 'package:m2m/Presentation/screens/tasks_screen/screen/tasks_screen.dart';
import 'package:m2m/Presentation/screens/view_courses/view_courses.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/assets_manager.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/login_cubit/login_state.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Container(
            width: SizeConfig.width *0.7,
            color: ColorManager.white,
            child: Column(
              children: [
                // user data
                Container(
                  height: SizeConfig.height*0.3,
                  width: SizeConfig.width *0.7,
                  decoration:  BoxDecoration(
                    color: ColorManager.lightBlue2,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    ),
                  ),
                  child: state is UserLoginLoadingState? const Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.secondDarkColor,
                    ),
                  ) :Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.height*0.05,
                      ),
                      // user image
                      SizedBox(
                        height: SizeConfig.height*0.11,
                        width: SizeConfig.height*0.11,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Material(
                              elevation: 5.0,
                              shadowColor: ColorManager.lightGrey,
                              borderRadius: BorderRadius.circular(500),
                              child: CircleAvatar(
                                backgroundColor: ColorManager.white,
                                radius: 42,
                              ),
                            ),
                            cubit.userModel!.profileImage =="null"? const CircleAvatar(
                              backgroundImage: AssetImage(AssetsManager.userImage),
                              radius: 40,
                            ) : CircleAvatar(
                              backgroundImage: NetworkImage(cubit.userModel!.profileImage.toString()),
                              radius: 40,
                            ),
                          ],
                        ),
                      ),


                      SizedBox(
                        height: SizeConfig.height*0.01,
                      ),

                      // user name
                      Text(
                        cubit.userModel!.username.toString(),
                        style: GoogleFonts.roboto(
                          color: ColorManager.secondDarkColor,
                          fontSize: SizeConfig.headline2Size,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.height*0.05,
                ),
                DrawerRowItem(
                  title: 'Profile',
                  image: "assets/images/user_profile.png",
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfileScreen())),
                ),
                SizedBox(
                  height: SizeConfig.height*0.02,
                ),
                DrawerRowItem(
                  title: 'Today Tasks',
                  image: "assets/images/task.png",
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const TasksScreen())),
                ),
                SizedBox(
                  height: SizeConfig.height*0.02,
                ),
                DrawerRowItem(
                  title: 'Packages',
                  image: "assets/images/packages.png",
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const PackageScreen())),
                ),
                SizedBox(
                  height: SizeConfig.height*0.02,
                ),
                DrawerRowItem(
                  title: 'Courses',
                  image: 'assets/images/courseImage.jpg',
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const ViewCourses())),
                ),
                SizedBox(
                  height: SizeConfig.height*0.02,
                ),
                DrawerRowItem(
                  title: 'Public Chat',
                  image: 'assets/images/public_chat.png',
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const PublicChatScreen())),
                ),
                SizedBox(
                  height: SizeConfig.height*0.02,
                ),
                SizedBox(
                  height: SizeConfig.height*0.02,
                ),
                DrawerRowItem(
                  title: 'Setting Screen',
                  image: 'assets/images/public_chat.png',
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>  const MoreScreen())),
                ),
                DrawerRowItem(
                  title: 'Logout',
                  image: "assets/images/logout.png",
                  onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginScreen())),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
