import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class SingleUser extends StatelessWidget {
  final UserModel userModel;
  const SingleUser({Key? key,required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){

      },
      builder: (context,state){
        Size size =MediaQuery.of(context).size;
        return Scaffold(

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('singleUser').toString(),
              style: GoogleFonts.aBeeZee(
                  color: ColorManager.black,
                  fontWeight: FontWeight.w500,
                  fontSize: size.height*.025
              ),),
            titleSpacing: 0,
            leading: IconButton(
              icon: Icon(
                IconBroken.Arrow___Left_2,
                color: ColorManager.black,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.white
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.height*.02
                ),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Image(
                          image: NetworkImage(userModel.profileImage),
                          height: SizeConfig.height*.15,
                        ),
                        SizedBox(width: SizeConfig.height*.022,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(userModel.username,
                                style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: SizeConfig.height*.015,),

                              Text(userModel.email,
                                style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: SizeConfig.height*.015,),
                              
                              Text(userModel.phone,
                                style: textManager(color: ColorManager.black,fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: SizeConfig.height*.04,),

                    Row(
                      children: [
                        Text('${AppLocalizations.of(context)!.translate('government').toString()} : ',
                          style: textManager(color: Colors.black,fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(userModel.government,
                            style: textManager(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Row(
                      children: [
                        Text('${AppLocalizations.of(context)!.translate('age').toString()} : ',
                          style: textManager(color: Colors.black,fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(userModel.age,
                            style: textManager(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Row(
                      children: [
                        Text('${AppLocalizations.of(context)!.translate('package').toString()} : ',
                          style: textManager(color: Colors.black,fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text(userModel.package.packageId,
                            style: textManager(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Row(
                      children: [
                        Text('${AppLocalizations.of(context)!.translate('code').toString()} : ',
                          style: textManager(color: Colors.black,fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text('Mahmoud Reda',
                            style: textManager(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Row(
                      children: [
                        Text('${AppLocalizations.of(context)!.translate('money').toString()} : ',
                          style: textManager(color: Colors.black,fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text('${userModel.wallet.money}',
                            style: textManager(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Row(
                      children: [
                        Text('${AppLocalizations.of(context)!.translate('points').toString()} : ',
                          style: textManager(color: Colors.black,fontWeight: FontWeight.w500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Expanded(
                          child: Text('${userModel.wallet.point}',
                            style: textManager(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: SizeConfig.height*.04,),

                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text('National Id Image :',
                        style: GoogleFonts.aBeeZee(
                            color: ColorManager.black,
                            fontWeight: FontWeight.w500,
                            fontSize: size.height*.023
                        ),),
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Container(
                      height: SizeConfig.height*.4,
                      width: SizeConfig.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(userModel.nationalIdImage),
                            fit: BoxFit.cover
                          )
                      ),
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text('Personal Image :',
                        style: GoogleFonts.aBeeZee(
                            color: ColorManager.black,
                            fontWeight: FontWeight.w500,
                            fontSize: size.height*.023
                        ),),
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    Container(
                      height: SizeConfig.height*.4,
                      width: SizeConfig.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                          image:DecorationImage(
                              image: NetworkImage(userModel.personalImage),
                              fit: BoxFit.cover
                          )
                      ),
                    ),

                    SizedBox(height: SizeConfig.height*.02,),

                    // block user
                    DefaultButton(
                      text: AppLocalizations.of(context)!.translate('blockUser').toString(),
                      onPressed: (){

                      },

                    ),
                    SizedBox(height: SizeConfig.height*.02,),


                  ],
                ),
              ),
            ),
          ),

        );

      },
    );
  }
}
