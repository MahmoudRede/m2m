import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Data/model/course_imgae.dart';
import 'package:m2m/Data/model/public_chat_model.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/Data/model/user_task.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/constants/constants.dart';
import 'dart:async';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:url_launcher/url_launcher.dart';


class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  final manager=CacheManager(
    Config('customCacheKey',
      stalePeriod: const Duration(days: 15),maxNrOfCacheObjects: 100,),
  );

  UserModel ?userModel;

  Future<void>getUser()async{

    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get()
        .then((value) {
      debugPrint('Get User Success');
      userModel=UserModel.fromMap(value.data()!);
      debugPrint(userModel!.email);

      CashHelper.saveData(key: 'userName',value: userModel!.username);
      CashHelper.saveData(key: 'userGovernment',value: userModel!.government);
      CashHelper.saveData(key: 'userPackage',value: userModel!.package.packageName);
      CashHelper.saveData(key: 'userPhone',value: userModel!.phone);
      CashHelper.saveData(key: 'userEmail',value: userModel!.email);
      updateWalletAndTasksState(userModel!.wallet.money);
      emit(GetUserSuccessState());
    }).catchError((error){
      debugPrint('Error When get user data ${error.toString()}');
      emit(GetUserErrorState());
    });
  }


  //  Get Users

  List <UserModel> users=[];
  List <UserModel>unConfirmedUsers=[];
  Future<void>getUsers()async{
    users=[];
    unConfirmedUsers=[];
    emit(GetUsersLoadingState());

    FirebaseFirestore.instance.collection('users')
        .get().then((value) {

      for (var element in value.docs) {
        users.add(UserModel.fromMap(element.data()));

        if(element.data()['isConfirmed'] ==false){
          unConfirmedUsers.add(UserModel.fromMap(element.data()));
        }

      }

      emit(GetUsersSuccessState());
    }).catchError((error){

      debugPrint('Error is ${error.toString()}');
      emit(GetUsersErrorState());
    });

  }

  String governmentDropDown = 'All';

  void changeGovernmentDropDown(value)
  {
    governmentDropDown = value ;
    emit(ChangeGovernmentDropDownState());
  }

  String skillsDropDown = 'All';

  void changeSkillsDropDown(value)
  {
    skillsDropDown = value ;
    emit(ChangeSkillsDropDownState());
  }

  String monthDropDown = 'All';

  void changeMonthDropDown(value)
  {
    monthDropDown = value ;
    emit(ChangeMonthDropDownState());
  }

  String yearDropDown = 'All';

  void changeYearDropDown(value)
  {
    yearDropDown = value ;
    emit(ChangeYearDropDownState());
  }

  String packageDropDown = 'All';

  void changePackageDropDown(value)
  {
    packageDropDown = value ;
    emit(ChangePackageDropDownState());
  }

  // push notification

  void saveToken(String token){

    emit(SaveTokenLoadingState());
    FirebaseFirestore.instance
        .collection('tokens')
        .doc('$uId')
        .set(
        {
          "token":token
        }
    ).then((value){

      debugPrint('Save Token Success');
      emit(SaveTokenSuccessState());
    }).catchError((error){

      debugPrint('Error in save token is ${error.toString()}');
      emit(SaveTokenErrorState());
    });

  }

  Future<void> getToken()async{

    emit(GetTokenLoadingState());
    FirebaseMessaging.instance
        .getToken()
        .then((token){

      saveToken(token!);
      debugPrint(token);

      emit(GetTokenSuccessState());
    }).catchError((error){

      debugPrint('Error in save token is ${error.toString()}');
      emit(GetTokenErrorState());
    });

  }


  /// update confirmed user

  Future<void> updateIsConfirmedUser({
    required String userId
  })async{

    emit(UpdateIsConfirmedUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .update({
      'isConfirmed':true
    }).then((value) {

      debugPrint('User Update Success');
      emit(UpdateIsConfirmedUserSuccessState());
    }).catchError((error){

      debugPrint('Error in update user is ${error.toString()}');
      emit(UpdateIsConfirmedUserErrorState());
    });

  }


  /// delete confirmed user

  Future<void> deleteUser({
    required String userId
  })async{

    emit(DeleteUserLoadingState());

    FirebaseAuth.instance.currentUser!.delete().then((value) {
      debugPrint("user deleted from fire auth");

      FirebaseFirestore.instance.collection('users')
          .doc(userId)
          .delete().then((value) {
        debugPrint('User Delete Success');
      }).catchError((error){
        debugPrint('Error in delete user is ${error.toString()}');
        emit(DeleteUserErrorState());
      });

      emit(DeleteUserSuccessState());

    }).catchError((error){
      debugPrint('Error when delete user from fire auth : ${error.toString()}');
      emit(DeleteUserErrorState());
    });

  }

  // ===============User Filter =================
  List <UserModel> filterUsers=[];
  Future<void>usersFilterion({
    required String government,
    required String month,
    required String year,
    required String package,
    required String skill,
  })async{
    filterUsers=[];

    emit(UsersFiltertionLoadingState());
    FirebaseFirestore.instance.collection('users')
        .get().then((value) {
      for (var element in value.docs) {

        if(element.data()['isConfirmed'] !=false && element.data()['package']['packageName'] !='not selected'){

          if (government == 'All' && month == 'All' && year == 'All' && package == 'All' && skill == 'All') {

            filterUsers.add(UserModel.fromMap(element.data()));

          }

          // ======================== skill ====================================

          if (government == 'All' && month == 'All' && year == 'All' &&
              package == 'All' && skill != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){

               filterUsers.add(UserModel.fromMap(element.data()));

            }
          }

          // ========================= government ===============================
          if (government != 'All' && month == 'All' && year == 'All' &&
              package == 'All') {

              if(skill !='All'){
                if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){

                  if (element.data()['government'] == government) {
                    filterUsers.add(UserModel.fromMap(element.data()));
                  }

                }

              }
              else{
                if (element.data()['government'] == government) {
                  filterUsers.add(UserModel.fromMap(element.data()));
                }
              }

          }

          if (government != 'All' && month == 'All' && year != 'All' &&
              package == 'All') {

            if(skill !='All'){
              if(element.data()['userSkill1']==skill ||
                  element.data()['userSkill2']==skill ||
                  element.data()['userSkill3']==skill ||
                  element.data()['userSkill4']==skill ||
                  element.data()['userSkill5']==skill ||
                  element.data()['userSkill6']==skill ||
                  element.data()['userSkill7']==skill ||
                  element.data()['userSkill8']==skill ){

                if (element.data()['government'] == government && element.data()['year'] == year) {
                  filterUsers.add(UserModel.fromMap(element.data()));
                }

              }

            }

            else if (element.data()['government'] == government && element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government == 'All' && month != 'All' && year == 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){

              if (element.data()['month'] == month && element.data()['package']['packageId'] == package) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['month'] == month && element.data()['package']['packageId'] == package) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month != 'All' && year == 'All' &&
              package == 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){

              if (element.data()['government'] == government &&
                  element.data()['month'] == month) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }


            else if (element.data()['government'] == government &&
                element.data()['month'] == month) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month != 'All' && year != 'All' &&
              package == 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){

              if (element.data()['government'] == government &&
                  element.data()['month'] == month &&
                  element.data()['year'] == year) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }


           else if (element.data()['government'] == government &&
                element.data()['month'] == month &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month != 'All' && year != 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){

              if (element.data()['government'] == government &&
                  element.data()['month'] == month &&
                  element.data()['year'] == year &&
                  element.data()['package']['packageId'] == package
              ) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }


           else if (element.data()['government'] == government &&
                element.data()['month'] == month &&
                element.data()['year'] == year &&
                element.data()['package']['packageId'] == package
            ) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }


          // ========================= month ===============================
          if (government == 'All' && month != 'All' && year == 'All' &&
              package == 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['month'] == month) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['month'] == month) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government == 'All' && month != 'All' && year != 'All' &&
              package == 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['month'] == month &&
                  element.data()['year'] == year) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['month'] == month &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }

          }

          if (government == 'All' && month != 'All' && year != 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['package']['packageId']  == package &&
                  element.data()['month'] == month &&
                  element.data()['year'] == year) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['package']['packageId']  == package &&
                element.data()['month'] == month &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          // ========================= year ===============================


          if (government == 'All' && month == 'All' && year != 'All' &&
              package == 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['year'] == year) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }

          }

          if (government == 'All' && month == 'All' && year != 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['package']['packageId']  == package &&
                  element.data()['year'] == year) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['package']['packageId']  == package &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month == 'All' && year != 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['package']['packageId']  == package &&
                  element.data()['government'] == government &&
                  element.data()['year'] == year) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['package']['packageId']  == package &&
                element.data()['government'] == government &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }
          // ========================= package ===============================

          if (government == 'All' && month == 'All' && year == 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['package']['packageId']  == package) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['package']['packageId']  == package) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month == 'All' && year == 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['package']['packageId']  == package &&
                  element.data()['government'] == government) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

            else if (element.data()['package']['packageId']  == package &&
                element.data()['government'] == government) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }


          if (government != 'All' && month != 'All' && year == 'All' &&
              package != 'All') {

            if(element.data()['userSkill1']==skill ||
                element.data()['userSkill2']==skill ||
                element.data()['userSkill3']==skill ||
                element.data()['userSkill4']==skill ||
                element.data()['userSkill5']==skill ||
                element.data()['userSkill6']==skill ||
                element.data()['userSkill7']==skill ||
                element.data()['userSkill8']==skill ){


              if (element.data()['package']['packageId'] == package &&
                  element.data()['government'] == government &&
                  element.data()['month'] == month) {
                filterUsers.add(UserModel.fromMap(element.data()));
              }

            }

           else if (element.data()['package']['packageId'] == package &&
                element.data()['government'] == government &&
                element.data()['month'] == month) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

        }

      }
      emit(GetUsersSuccessState());
    }).catchError((error){

      debugPrint('Error is ${error.toString()}');
      emit(GetUsersErrorState());
    });

  }

// =============== Add Task =================

  List <bool> isUserSelected = List.generate(250, (index) => false);
  bool selectAll = false;
  List <String> usersId=[];

  Future<void> addTasks({
    required String taskUrl,
    required String taskDescription,
    required String taskType,
    required String taskTimer,
    required String taskPrice,
  })async{
    emit(AddAdminTaskLoadingState());

    UserTaskModel userTaskModel=UserTaskModel(
      taskId: "id",
      taskDescription: taskDescription,
      taskType: taskType,
      taskTimer: taskTimer,
      taskPrice: taskPrice,
      taskIsConfirmed: false,
      taskIsUploaded: false,
      taskUrl: taskUrl,
    );

    for (var element in usersId) {

      FirebaseFirestore.instance.
      collection('adminTasks').
      doc(element).
      collection('userTasks').
      add(userTaskModel.toMap()).
      then((value) {
        value.update({
          "taskId":value.id.toString(),
        });
        debugPrint('Task add to user id is $element');
        emit(AddAdminTaskSuccessState());
      }).catchError((error){
        debugPrint('Error in add admin task is ${error.toString()}');
        emit(AddAdminTaskErrorState());

      });

    }

  }

  // upload user image

  File? profileImage;

  ImageProvider profile = const AssetImage('assets/images/imageProfile.jpg');

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profile = FileImage(profileImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickProfileImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickProfileImageErrorState());
    }

  }


  String ?profilePath;

  Future uploadUserImage(){

    emit(UploadProfileImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('usersImage/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        debugPrint('Upload Success');
        profilePath = value;

        FirebaseFirestore.instance.collection('users').doc('$uId').update({
          'profileImage':'$profilePath'
        }).then((value) {

          debugPrint('Image Updates');
        });

        getUser();
        emit(UploadProfileImageSuccessState());

      }).catchError((error){

        debugPrint('Error in Upload profileImage ${error.toString()}');
        emit(UploadProfileImageErrorState());

      });

    }).catchError((error){

      debugPrint('Error in Upload profileImage ${error.toString()}');
      emit(UploadProfileImageErrorState());
    });
  }

  // upload course image

  void addCourse({
    required String courseTitle,
    required String courseLink,
    required String courseImage,
  }){

    emit(AddCourseLoadingState());
    CourseModel courseModel= CourseModel(
        courseTitle: courseTitle,
        courseLink: courseLink,
        courseImage: courseImage
    );

    FirebaseFirestore.instance
        .collection('courses')
        .add(courseModel.toMap())
        .then((value){

      debugPrint('Add Course Success');
      emit(AddCourseSuccessState());

    }).catchError((error){

      debugPrint('Error in addCourse is ${error.toString()}');
      emit(AddCourseErrorState());

    });

  }


  File? courseImage;

  ImageProvider course = const AssetImage('assets/images/imageProfile.jpg');

  var picker2 = ImagePicker();

  Future<void> getCourseImage() async {
    final pickedFile = await picker2.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      courseImage = File(pickedFile.path);
      course = FileImage(courseImage!);
      debugPrint('Path is ${pickedFile.path}');
      emit(PickCourseImageSuccessState());
    } else {
      debugPrint('No Image selected.');
      emit(PickCourseImageErrorState());
    }

  }


  String ?coursePath;

  Future <void>uploadCourseImage({
    required String courseTitle,
    required String courseLink,
  })async{

    emit(UploadCourseImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('courseImage/${Uri.file(courseImage!.path).pathSegments.last}')
        .putFile(courseImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        debugPrint('Upload Success');
        coursePath = value;
        addCourse(
          courseTitle: courseTitle,
          courseLink: courseLink,
          courseImage: coursePath!,
        );

        emit(UploadCourseImageSuccessState());

      }).catchError((error){

        debugPrint('Error in Upload courseImage ${error.toString()}');
        emit(UploadCourseImageErrorState());

      });

    }).catchError((error){

      debugPrint('Error in Upload courseImage ${error.toString()}');
      emit(UploadCourseImageErrorState());
    });
  }


  List <CourseModel> coursesList=[];
  void getCourse(){

    emit(GetCourseLoadingState());

    FirebaseFirestore.instance
        .collection('courses')
        .get()
        .then((value){

      debugPrint('get Course Success');
      for (var element in value.docs) {

        coursesList.add(CourseModel.fromMap(element.data()));

      }
      debugPrint('Course getting ');
      emit(GetCourseSuccessState());

    }).catchError((error){

      debugPrint('Error in getCourse is ${error.toString()}');
      emit(GetCourseErrorState());

    });

  }

  Future <void> toCourseLink(
      {
        required String courseLink
      })async
  {
    String url= courseLink;
    await launch(url , forceSafariVC: false);
    emit(NavigateToCourseLinkSuccessState());
  }


  // ================== Public Chat ============

  Future<void> sendPublicChat({
    required String dateTime,
    required String text,

  })async{

    PublicChatModel publicChatModel =PublicChatModel(
        senderId: uId,
        dateTime: dateTime,
        text: text,
        senderName:userModel!.username,
        senderImage: userModel!.profileImage
    );

    emit(SendPublicChatLoadingState());

    FirebaseFirestore.instance
        .collection('publicChat')
        .add(publicChatModel.toMap())
        .then((value){

      debugPrint('Send Message Success');
      emit(SendPublicChatSuccessState());
    }).catchError((error){

      debugPrint('Error in public chat is ${error.toString()}');
      emit(SendPublicChatErrorState());

    });

  }


  List<PublicChatModel> publicChat=[];

  void getPublicChat(){

    emit(GetPublicChatLoadingState());
    FirebaseFirestore.instance
        .collection('publicChat')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      publicChat = [];
      for (var element in event.docs) {
        publicChat.add((PublicChatModel.fromJson(element.data())));
      }
      emit(GetPublicChatSuccessState());
    });
  }


  bool isWritingPublicChat=false;
  void changeIconPublicChat(){
    isWritingPublicChat!=isWritingPublicChat;
    emit(ChangeIconPublicChatSuccessState());
  }


  var myWallet = 0;
  var dayProfit = 0;

  Future<void> getLastProfitState()async{
    if(CashHelper.getData(key: CashHelper.lastWalletAmountKey).toString() == "null"){
      CashHelper.saveData(key: CashHelper.lastWalletDateUpdateKey, value: DateTime.now().day.toString());
      debugPrint('add wallet initial value');
    }

    myWallet = CashHelper.getData(key: CashHelper.lastWalletAmountKey);
    dayProfit = userModel!.wallet.money - myWallet;
    emit(GetLastProfitState());
  }


  Future<void> getCurrentWalletState()async{
    if(CashHelper.getData(key: CashHelper.lastWalletAmountKey).toString() == "null"){
      CashHelper.saveData(key: CashHelper.lastWalletDateUpdateKey, value: DateTime.now().day.toString());
      debugPrint('add wallet initial value');
      emit(ChangeLastWalletState());
    }
    else if(CashHelper.getData(key: CashHelper.lastWalletDateUpdateKey) != DateTime.now().day.toString())
    {
      CashHelper.saveData(key: CashHelper.lastWalletAmountKey, value: userModel!.wallet.money);
      emit(ChangeLastWalletState());
    }

  }


  late String todayDate;
  late String yesterdayDate;
  final now = DateTime.now();

  Future<void> updateWalletAndTasksState(wallet)async{
    _setupDateDisplay().then((todayDate){
      _checkDate(todayDate, wallet);
    });
    emit(ChangeLastWalletState());
  }

  Future<String> _setupDateDisplay() async {

    todayDate = DateFormat.yMMMMd().format(now);
    return todayDate;
  }

  _checkDate(String todayDate , wallet) async{
    String yesterdayDate = CashHelper.getData(key: CashHelper.lastWalletDateUpdateKey) ?? '';

    if (todayDate != yesterdayDate){
      //SHOW NEW CONTENT
      CashHelper.saveData(key: CashHelper.lastWalletDateUpdateKey, value: todayDate);
      CashHelper.saveData(key: CashHelper.lastWalletAmountKey, value: wallet);
      debugPrint('wallet is updated ${CashHelper.getData(key: CashHelper.lastWalletAmountKey)}');
      CashHelper.saveData(key: CashHelper.lastWalletDateUpdateKey, value: todayDate);
      FirebaseFirestore.instance.collection('adminTasks').doc(userModel!.uId).delete().then((value) {
        debugPrint('user tasks are deleted success');
      });
    }else{
      //SHOW SAME CONTENT
      String currentWallet = CashHelper.getData(key: CashHelper.lastWalletAmountKey).toString();
      debugPrint('my Current wallet is : $currentWallet');
    }

  }


  Future userUnsubscribe({required String id})async{
    emit(UnsubscribeUserLoadingState());

    FirebaseFirestore.instance.collection('users')
        .doc(id)
        .update({
      "package" : {
        "isVerified" : false,
        "packageId":"id",
        "packageName":"not selected",
      },
    }).then((value){
      debugPrint('User unsubscribe success');
      emit(UnsubscribeUserSuccessState());
    }).catchError((error){
      debugPrint('Error When unsubscribe user : ${error.toString()}');
      emit(UnsubscribeUserErrorState());
    });


  }



}