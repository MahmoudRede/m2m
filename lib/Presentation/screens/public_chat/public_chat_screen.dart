import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                      icon: Icon(
                        IconBroken.Arrow___Left_2,
                        color: ColorManager.white,
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
                                                    text: textMessage.text);
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
                          ),

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

