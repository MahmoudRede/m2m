import 'package:flutter/material.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class UserItem extends StatelessWidget {

  final UserModel userModel;

  const UserItem({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: SizeConfig.height*.02,
        right: SizeConfig.height*.02,
        bottom: SizeConfig.height*.0,
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
                    backgroundImage: NetworkImage(userModel.profileImage),
                    radius: SizeConfig.height*.03,
                  ),
                  SizedBox(width: SizeConfig.height*.01,),
                  Expanded(
                    child: Text(userModel.username,
                      style: textManager(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
