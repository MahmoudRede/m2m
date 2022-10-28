import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:m2m/Data/core/remote/notification.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/Presentation/widgets/default_button.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';

class ConfirmUserRequest extends StatelessWidget {

  final String personalImage;
  final String nationalCard;
  final String userId;
  const ConfirmUserRequest({Key? key,required this.personalImage,required this.nationalCard,required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= AppCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.white,

          // title
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: 0.0,
            title: Text(AppLocalizations.of(context)!.translate('identityConfirmation').toString(),
              style: GoogleFonts.aBeeZee(
                color: ColorManager.black,
                fontWeight: FontWeight.w500,
                fontSize: size.height*.03
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
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: SizeConfig.height*.04, vertical: SizeConfig.height*.01),
              child: Column(
                children: [

                  // national image
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                      ),
                      child: CachedNetworkImage(
                        cacheManager: cubit.manager,
                        imageUrl: nationalCard,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height*.04,),

                  // personal image
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: ColorManager.primary,
                          ),
                      ),
                      child: CachedNetworkImage(
                        cacheManager: cubit.manager,
                        imageUrl: personalImage,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  SizedBox(height: size.height*.05,),

                  // accept and refuse buttons
                  Row(
                    children: [

                      // accept
                      Expanded(
                        child: DefaultButton(
                            text: AppLocalizations.of(context)!.translate('accept').toString(),
                            color: ColorManager.primary,
                            onPressed: (){
                                cubit.updateIsConfirmedUser(userId: userId).then((value) {

                                  FirebaseFirestore.instance.collection('tokens').doc(userId).get().then((value) {

                                    callFcmApiSendPushNotificationsChat(
                                      token: value.data()!['token'],
                                      title: 'Attention please!',
                                      description:'Congratulations, you are accept to join to M2M Team',
                                      imageUrl: 'assets/images/dollar.png',
                                    );

                                  });

                                  cubit.getUsers();
                                  customToast(title: 'User is Accept', color: ColorManager.primary);
                                  Navigator.pop(context);
                                });
                            }
                        ),
                      ),

                      SizedBox(width: SizeConfig.height*.02,),

                      // refuse
                      Expanded(
                        child: DefaultButton(
                            text: AppLocalizations.of(context)!.translate('refuse').toString(),
                            color: ColorManager.red,
                            onPressed: (){
                              cubit.deleteUser(userId: userId).then((value) {

                                FirebaseFirestore.instance.collection('tokens').doc(userId).get().then((value) {

                                  callFcmApiSendPushNotificationsChat(
                                    token: value.data()!['token'],
                                    title: 'Attention please!',
                                    description:'Unfortunately, you are refuse to join to M2M Team,check your information that you are enter it',
                                    imageUrl: 'assets/images/dollar.png',
                                  );

                                });

                                cubit.getUsers();
                                customToast(title: 'User is Refuse', color: ColorManager.red);
                                Navigator.pop(context);

                              });
                            }
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),


        );
      },
    );
  }
}
