import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m2m/Data/model/task_model.dart';
import 'package:m2m/Data/model/upload_task_model.dart';
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
      userModel=UserModel.fromMap(value.data()!);
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


  List<String> userTaskImages = [];

  Future<void> uploadTaskImage ()async {
    emit(UploadTaskImageLoadingState());
    FirebaseStorage.instance.ref()
        .child('tasksImages/${Uri.file(uploadedTaskImage!.path)
        .pathSegments.last}').putFile(uploadedTaskImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {

        // add uploaded image to userTasks images
        userTaskImages.add(value.toString());

        emit(UploadTaskImageSuccessState());
      }).catchError((error){
        debugPrint('Error When get upload task image link : ${error.toString()}');
        customToast(title: 'Sorry time is out try again', color: ColorManager.red);
        emit(UploadTaskImageErrorState());
      });
    }).catchError((error){
      debugPrint('Error When Upload image in Firesorage : ${error.toString()}');
      customToast(title: 'Sorry time is out try again', color: ColorManager.red);
      emit(UploadTaskImageErrorState());
    });
  }



  Future<void> uploadTask ()async {
    await getUser();
    emit(UploadTaskLoadingState());

    final UploadTaskModel uploadTaskModel = UploadTaskModel(
      taskId: "id",
      taskImages: userTaskImages,
      userName: userModel!.username.toString(),
      userImage: userModel!.personalImage.toString(),
      userUId: userModel!.uId.toString(),
      taskConfirmed: false,
      packageName: userModel!.package.packageName.toString(),
      phone: userModel!.phone.toString(),
    );

    FirebaseFirestore.instance.collection('uploadedTasks')
        .doc(userModel!.uId.toString())
        .collection('tasks')
        .add(uploadTaskModel.toMap())
        .then((value){
          value.update({
            "taskId":value.id.toString(),
          });
          debugPrint('task Added Successfully');
          emit(UploadTaskSuccessState());
    }).catchError((error){
      debugPrint('Error When upload task screen : ${error.toString()}');
      customToast(title: 'Sorry time is out try again', color: ColorManager.red);
      emit(UploadTaskErrorState());
    });

  }






  List<TaskModel> todayTasks = [];

  // get user today tasks
  Future<void> getTodayTasks()async{
    await getUser();
    emit(GetTodayTaskLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(userModel!.uId.toString())
        .collection('tasks')
        .get()
        .then((value){
          for (var element in value.docs) {
            todayTasks.add(TaskModel.fromMap(element.data()));
          }
          if (kDebugMode) {
            print('Get tasks is success : ${todayTasks[0].toString()}');
          }
          emit(GetTodayTaskSuccessState());
    }).catchError((error){
      if (kDebugMode) {
        print('Error when get Tasks ===> ${error.toString()}');
      }
      customToast(title: 'Sorry time is out try again', color: ColorManager.red);
      emit(GetTodayTaskErrorState());
    });

  }
  
  
  List<UserModel> userWhoUploadedTasks = [];
  
  Future<void> getUsersWhoUploadedTasks()async{
    userWhoUploadedTasks = [];
    emit(GetUsersWhoUploadedTaskLoadingState());
    
    FirebaseFirestore.instance.collection('users')
        .get()
        .then((value) {
          for (var element in value.docs) {
            userWhoUploadedTasks.add(UserModel.fromMap(element.data()));
          }
          debugPrint('user who uploaded tasks ${userWhoUploadedTasks.length}');
          emit(GetUsersWhoUploadedTaskSuccessState());
    }).catchError((error){
      debugPrint('Error when get user who uploaded tasks ==> ${error.toString()}');
      emit(GetUsersWhoUploadedTaskErrorState());
    });
  }


  List<UploadTaskModel> userUploadedTasks = [];
  Future<void> getUsersUploadedTasks({required userId})async{
    emit(GetUserUploadedTaskLoadingState());

    FirebaseFirestore.instance.collection('uploadedTasks')
        .doc(userId)
        .collection('tasks')
        .get()
        .then((value) {
      for (var element in value.docs) {
        userUploadedTasks.add(UploadTaskModel.fromMap(element.data()));
      }
      debugPrint("all user tasks is : ${userUploadedTasks.length}");
      emit(GetUserUploadedTaskSuccessState());
    }).catchError((error){
      debugPrint("Error when get all user uploaded tasks is : ${error.toString()}");
      emit(GetUserUploadedTaskErrorState());
    });

  }
  
  
  Future<void> confirmTask({required UploadTaskModel taskModel})async{
    emit(ConfirmTaskLoadingState());
    
    FirebaseFirestore.instance.collection('uploadedTasks')
        .doc(taskModel.userUId.toString())
        .collection('tasks')
        .doc(taskModel.taskId.toString())
        .update({"taskConfirmed" : true,})
        .then((value) {
          debugPrint("Task confirmed success");
          emit(ConfirmTaskSuccessState());
    }).catchError((error){
      debugPrint("Error when task confirm");
      emit(ConfirmTaskErrorState());
    });

  }
 

}