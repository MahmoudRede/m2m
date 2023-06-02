import 'package:flutter/material.dart';
import 'package:m2m/Presentation/screens/admin_screens/user_request/confirm_user_request.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/navigate_to.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';

class UserRequestItem extends StatelessWidget {
  final String userName;
  final String email;
  final String phone;
  final String government;
  final String personalImage;
  final String nationalCard;
  final String userId;
  const UserRequestItem({Key? key,
    required this.userName,
    required this.email,
    required this.phone,
    required this.government,
    required this.personalImage,
    required this.nationalCard,
    required this.userId,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, ConfirmUserRequest(personalImage: personalImage,nationalCard: nationalCard,userId: userId,));
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
                      child: Text(userName,
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
                      child: Text(email,
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
                      child: Text(phone,
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
                      child: Text(government,
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
  }
}
