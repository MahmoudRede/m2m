import 'package:flutter/material.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class FilterUserItem extends StatelessWidget {
  final int index;
  final UserModel userModel;
  const FilterUserItem({Key? key,required this.index,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: SizeConfig.height*.02,
      ),
      child:SizedBox(
        height: SizeConfig.height*.19,
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
              children: [
                Row(
                  children: [

                    // name
                    Expanded(
                      child: Text(userModel.username,
                        style: textManager(
                            color: ColorManager.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),

                    // select icon
                    GestureDetector(
                      onTap: (){},
                      child: const Icon(
                        Icons.circle_outlined,
                        color: Colors.white,
                      ),
                    )


                  ],
                ),

                SizedBox(height:SizeConfig.height*.01,),
                Row(
                  children: [

                    // government
                    Expanded(
                      child: Text(userModel.government,
                        style: textManager(
                            color: ColorManager.white,
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.height*.02
                        ),
                      ),
                    ),

                    // code
                    Text('2155',
                      style: textManager(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.height*.025
                      ),
                    ),

                  ],
                ),
                SizedBox(height:SizeConfig.height*.01,),

                // Package

                Row(
                  children: [

                    Text('Package ',
                      style: textManager(
                          color: ColorManager.white,
                          fontWeight: FontWeight.w400,
                          fontSize: SizeConfig.height*.02
                      ),
                    ),

                    SizedBox(width: SizeConfig.height*.03,),

                    Text('${userModel.package.packageName} \$',
                      style: textManager(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.w700,
                          fontSize: SizeConfig.height*.025
                      ),
                    ),


                  ],
                ),

                SizedBox(height:SizeConfig.height*.01,),

                // skills
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text('Photoshop , Microsoft office , Translation',
                    style: textManager(
                        color: ColorManager.white,
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.height*.02
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),

    );
  }
}
