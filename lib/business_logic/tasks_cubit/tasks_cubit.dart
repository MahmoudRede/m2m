import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_states.dart';
import 'package:m2m/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TasksCubit extends Cubit<TasksStates>{

  TasksCubit() : super(InitialState());

  static TasksCubit get(context) => BlocProvider.of(context);

  UserModel ?userModel;

  Future<void>getUser()async{

    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get().then((value) {
      debugPrint('Get User Success');
      userModel=UserModel.formJson(value.data()!);
      debugPrint(userModel!.email);
      emit(GetUserSuccessState());
    }).catchError((error){
      debugPrint('Error is ${error.toString()}');
      emit(GetUserErrorState());
    });

  }

  File? uploadedTaskImage;
  var imagePicker = ImagePicker();

  Future <void> getTaskImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadedTaskImage = File(pickedFile.path);
      emit(UploadImageSuccessState());
    } else {
      print('No Image selected.');
      emit(UploadImageErrorState());
    }
  }


  Future <void> urlLunch({required String taskLink}) async {
    String url= taskLink;
    await launch(url , forceSafariVC: false);
    emit(UrlLaunchState());
  }


  Future <void> uploadTaskScreen ()async
  {
    await getUser();
    emit(UploadTaskScreenLoadingState());
    FirebaseStorage.instance.ref()
        .child('tasksImages/${Uri.file(uploadedTaskImage!.path)
        .pathSegments.last}').putFile(uploadedTaskImage!)
        .then((value){

      value.ref.getDownloadURL().then((value) {
        final Map <String ,dynamic> taskParameter = {
          "taskImage" : value.toString(),
          "userName" : userModel!.username,
          "userImage" : userModel!.personalImage,
          "userUId" : userModel!.uId,
          "taskConfirmed" : false,
          "package" : userModel!.package,
          "phone" : userModel!.phone,
        };

        FirebaseFirestore.instance.collection('uploadedTasks').doc().set(taskParameter)
            .then((value){
          if (kDebugMode) {
            print('task screen Added Successfully');
          }
          emit(UploadTaskScreenSuccessState());
        }).catchError((error){
          if (kDebugMode) {
            print('Error When upload task screen : ${error.toString()}');
          }
          customToast(title: 'Sorry time is out try again', color: ColorManager.red);
          emit(UploadTaskScreenErrorState());
        });
      }).catchError((error){
        if (kDebugMode) {
          print('Error When upload task screen : ${error.toString()}');
        }
        customToast(title: 'Sorry time is out try again', color: ColorManager.red);
        emit(UploadTaskScreenErrorState());
      });
    }).catchError((error){
      if (kDebugMode) {
        print('Error When Upload image in Firesorage : ${error.toString()}');
      }
      customToast(title: 'Sorry time is out try again', color: ColorManager.red);
      emit(UploadTaskScreenErrorState());
    });
  }


}