import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/public_chat/public_chat_my_message_widget.dart';
import 'package:m2m/Presentation/styles/app_size_config.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/styles/icon_broken.dart';
import 'package:m2m/Presentation/widgets/text_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'public_chat_reseiver_widget.dart';

class PublicChatScreen extends StatefulWidget {

  const PublicChatScreen({Key? key}) : super(key: key);

  @override
  State<PublicChatScreen> createState() => _PublicChatScreenState();
}

class _PublicChatScreenState extends State<PublicChatScreen> {

  var textMessage = TextEditingController();
  bool isWriting = false;
  ScrollController scrollController = ScrollController();


  @override
  void initState() {

    super.initState();

    // chat_bot message

    if( CashHelper.getData(key: 'oneValue')==null && AppCubit.get(context).userModel!.wallet.money>=250 && AppCubit.get(context).userModel!.wallet.money<500){

      AppCubit.get(context).sendPublicChat(
          dateTime: DateTime.now().toString(),
          text: '${AppCubit.get(context).userModel!.username} gain ${AppCubit.get(context).userModel!.wallet.money}',
          senderImage: 'https://firebasestorage.googleapis.com/v0/b/m2mapp-91014.appspot.com/o/5500_1_06.jpg?alt=media&token=68645781-c54e-4ff0-ab92-0579f49067a0',
          senderName: 'System',
          id:'12225'
      ).then((value) {
        CashHelper.saveData(key: 'oneValue',value: true);
      });

    }
    else if(AppCubit.get(context).userModel!.wallet.money>=500 && AppCubit.get(context).userModel!.wallet.money<1000 && CashHelper.getData(key: 'twoValue')==null){

      AppCubit.get(context).sendPublicChat(
          dateTime: DateTime.now().toString(),
          text: '${AppCubit.get(context).userModel!.username} gain ${AppCubit.get(context).userModel!.wallet.money}',
          senderImage: 'https://firebasestorage.googleapis.com/v0/b/m2mapp-91014.appspot.com/o/5500_1_06.jpg?alt=media&token=68645781-c54e-4ff0-ab92-0579f49067a0',
          senderName: 'System',
          id: '12225'
      ).then((value) {

        CashHelper.saveData(key: 'twoValue',value: true);

      });

    }
    else if(AppCubit.get(context).userModel!.wallet.money>=1000 && AppCubit.get(context).userModel!.wallet.money<1500 && CashHelper.getData(key: 'threeValue')==null){

      AppCubit.get(context).sendPublicChat(
          dateTime: DateTime.now().toString(),
          text: '${AppCubit.get(context).userModel!.username} gain ${AppCubit.get(context).userModel!.wallet.money}',
          senderImage: 'https://firebasestorage.googleapis.com/v0/b/m2mapp-91014.appspot.com/o/5500_1_06.jpg?alt=media&token=68645781-c54e-4ff0-ab92-0579f49067a0',
          senderName: 'System',
          id: '12225'
      ).then((value) {

        CashHelper.saveData(key: 'threeValue',value: true);

      });

    }
    else if(AppCubit.get(context).userModel!.wallet.money>=1500 && AppCubit.get(context).userModel!.wallet.money<2000 && CashHelper.getData(key: 'fourValue')==null){

      AppCubit.get(context).sendPublicChat(
          dateTime: DateTime.now().toString(),
          text: '${AppCubit.get(context).userModel!.username} gain ${AppCubit.get(context).userModel!.wallet.money}',
          senderImage: 'https://firebasestorage.googleapis.com/v0/b/m2mapp-91014.appspot.com/o/5500_1_06.jpg?alt=media&token=68645781-c54e-4ff0-ab92-0579f49067a0',
          senderName: 'System',
          id: '12225'
      ).then((value) {

        CashHelper.saveData(key: 'fourValue',value: true);

      });

    }

    if(scrollController.hasClients){
      scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
    }
    isWriting = false;
  }

  @override
  Widget build(BuildContext context) {

    return ConditionalBuilder(
      builder: (context)=>Builder(
          builder: (context) {
            if(scrollController.hasClients){
              scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
            }
            AppCubit.get(context).getPublicChat();
            return BlocConsumer<AppCubit,AppStates>(
              listener: (context,state){

              },
              builder: (context,state){
                if(scrollController.hasClients){
                  scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.linear);
                }
                return Scaffold(
                  backgroundColor: Colors.white,

                  // title && public chat image
                  appBar: AppBar(
                    backgroundColor: ColorManager.primary,
                    elevation: 0.0,
                    title: Row(
                      children: [

                        CircleAvatar(
                          radius: SizeConfig.height*.032,
                          backgroundImage: const AssetImage('assets/images/chat.png'),
                        ),

                        SizedBox(width: SizeConfig.height*.015,),

                        Text(AppLocalizations.of(context)!.translate('publicChat').toString(),
                          style: GoogleFonts.aBeeZee(
                              color: ColorManager.white,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.height*.027
                          ),),
                      ],
                    ),
                    titleSpacing: 0,
                    leading: IconButton(
                      icon: CashHelper.getData(key: CashHelper.languageKey).toString()=='en'?Icon(
                        IconBroken.Arrow___Left_2,
                        color: ColorManager.black,
                      ):Icon(
                        IconBroken.Arrow___Right_2,
                        color: ColorManager.black,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.light,
                        statusBarColor: Colors.transparent,
                    ),
                  ),

                  body: SafeArea(
                    child: ConditionalBuilder(
                      builder: (context)=>Column(
                        children: [

                          // List view of chats
                          Expanded(
                            child: Container(
                              height:MediaQuery.of(context).size.height*.83,
                              padding: const EdgeInsets.all(10),
                              child: ListView.separated(
                                  controller: scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context , index)
                                  {
                                    var publicChat =AppCubit.get(context).publicChat[index];
                                    if(AppCubit.get(context).userModel!.uId == publicChat.senderId) {

                                      // my message
                                      return MyMessagePublicChatWidget(index: index);
                                    }

                                    //receive message
                                    return ResieverPublicChatWidget(index: index,);
                                  },

                                  separatorBuilder: (context,index)=> const SizedBox(height: 15,),

                                  itemCount: AppCubit.get(context).publicChat.length),
                            ),
                          ),
                          
                          // write a message && send message
                          AppCubit.get(context).userModel!.wallet.money>=100?
                          Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [

                                  // write a message

                                  Expanded(
                                    child: Container(
                                      width: SizeConfig.width*.70,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: ColorManager.primary, width: 1),
                                        borderRadius: BorderRadius.circular(SizeConfig.height*.2),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.only(left: SizeConfig.width*.03),
                                          child: TextFormField(
                                            onChanged: (v){
                                              setState((){
                                                isWriting=true;
                                              });
                                            },
                                            style: textManager(color: ColorManager.black,),
                                            keyboardType: TextInputType.multiline,
                                            maxLines: null,
                                            controller: textMessage,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Write your message...',
                                              hintStyle: textManager(color: ColorManager.primary,fontSize: SizeConfig.height*.022),
                                            ),
                                          ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: SizeConfig.height*.005,),


                                  // send icon
                                  Padding(
                                    padding:EdgeInsets.only(bottom: SizeConfig.height*.005,left: SizeConfig.height*.005),

                                    child: Container(
                                        width:SizeConfig.height*.05,
                                        height: SizeConfig.height*.05,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(SizeConfig.height*.05),
                                          color: ColorManager.primary,
                                        ),
                                        child: Center(
                                          child: IconButton(
                                              onPressed: (){
                                                HapticFeedback.vibrate();
                                                AppCubit.get(context).sendPublicChat(
                                                    dateTime: DateTime.now().toString(),
                                                    text: textMessage.text
                                                );
                                                textMessage.clear();
                                              },
                                              color: ColorManager.primary,
                                              icon: Icon(Icons.send,color: Colors.white,size: SizeConfig.height*.028)
                                          ),
                                        )
                                    ),
                                  ),

                                  SizedBox(width: SizeConfig.height*.005,),
                                ],
                              )
                          ) :
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all( SizeConfig.height*.02),
                                height: SizeConfig.height*.07,
                                width: double.infinity,
                                color: ColorManager.primary,
                                child: Text('Not allow foy you to send messages',
                                  style: textManager(color: Colors.white,fontSize:SizeConfig.height*.02 ),
                                ),
                              )

                        ],
                      ),
                      condition: AppCubit.get(context).publicChat.length >=0,
                      fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                    ),
                  ),

                );
              },
            );
          }
      ),
      condition: AppCubit.get(context).userModel !=null,
      fallback: (context)=>const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

}

