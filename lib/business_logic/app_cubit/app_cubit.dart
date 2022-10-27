import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/Data/model/user_task.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/constants/constants.dart';
import 'dart:async';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';


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

  void getToken(){

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
    FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .delete().then((value) {

      debugPrint('User Delete Success');
      emit(DeleteUserSuccessState());
    }).catchError((error){

      debugPrint('Error in delete user is ${error.toString()}');
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
    })async{
    filterUsers=[];

    emit(UsersFiltertionLoadingState());
    FirebaseFirestore.instance.collection('users')
        .get().then((value) {
      for (var element in value.docs) {

        if(element.data()['isConfirmed'] !=false && element.data()['package']['packageName'] !='not selected'){

          if (government == 'All' && month == 'All' && year == 'All' && package == 'All') {

            filterUsers.add(UserModel.fromMap(element.data()));

          }

          // ========================= government ===============================
          if (government != 'All' && month == 'All' && year == 'All' &&
              package == 'All') {
            if (element.data()['government'] == government) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month == 'All' && year != 'All' &&
              package == 'All') {
            if (element.data()['government'] == government && element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government == 'All' && month != 'All' && year == 'All' &&
              package != 'All') {
            if (element.data()['month'] == month && element.data()['package']['packageName'] == package) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month != 'All' && year == 'All' &&
              package == 'All') {
            if (element.data()['government'] == government &&
                element.data()['month'] == month) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month != 'All' && year != 'All' &&
              package == 'All') {
            if (element.data()['government'] == government &&
                element.data()['month'] == month &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month != 'All' && year != 'All' &&
              package != 'All') {
            if (element.data()['government'] == government &&
                element.data()['month'] == month &&
                element.data()['year'] == year &&
                element.data()['package']['packageName'] == package
            ) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }


          // ========================= month ===============================
          if (government == 'All' && month != 'All' && year == 'All' &&
              package == 'All') {
            if (element.data()['month'] == month) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government == 'All' && month != 'All' && year != 'All' &&
              package == 'All') {
            if (element.data()['month'] == month &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government == 'All' && month != 'All' && year != 'All' &&
              package != 'All') {
            if (element.data()['package']['packageName']  == package &&
                element.data()['month'] == month &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          // ========================= year ===============================
          if (government == 'All' && month == 'All' && year != 'All' &&
              package == 'All') {
            if (element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government == 'All' && month == 'All' && year != 'All' &&
              package != 'All') {
            if (element.data()['package']['packageName']  == package &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month == 'All' && year != 'All' &&
              package != 'All') {
            if (element.data()['package']['packageName']  == package &&
                element.data()['government'] == government &&
                element.data()['year'] == year) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }
          // ========================= package ===============================
          if (government == 'All' && month == 'All' && year == 'All' &&
              package != 'All') {
            if (element.data()['package']['packageName']  == package) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month == 'All' && year == 'All' &&
              package != 'All') {
            if (element.data()['package']['packageName']  == package &&
                element.data()['government'] == government) {
              filterUsers.add(UserModel.fromMap(element.data()));
            }
          }

          if (government != 'All' && month != 'All' && year == 'All' &&
              package != 'All') {
            if (element.data()['package']['packageName'] == package &&
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
      required String taskTitle,
      required String taskDescription,
      required String taskType,
      required String taskTimer,
      required String taskPrice,
    })async{
      emit(AddAdminTaskLoadingState());
      UserTaskModel userTaskModel=UserTaskModel(
          taskTitle: taskTitle,
          taskDescription: taskDescription,
          taskType: taskType,
          taskTimer: taskTimer,
          taskPrice: taskPrice
      );

       for (var element in usersId) {

         FirebaseFirestore.instance.
         collection('adminTasks').
         doc(element).
         collection('userTasks').
         add(userTaskModel.toMap()).
         then((value) {

           debugPrint('Task add to user id is $element');
           emit(AddAdminTaskSuccessState());

         }).catchError((error){

           debugPrint('Error in add admin task is ${error.toString()}');
           emit(AddAdminTaskErrorState());

         });

       }

    }



}