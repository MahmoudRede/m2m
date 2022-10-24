import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:m2m/constants/constants.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

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

    emit(GetUsersLoadingState());

    FirebaseFirestore.instance.collection('users')
        .get().then((value) {

          for (var element in value.docs) {
            users.add(UserModel.formJson(element.data()));

            if(element.data()['isConfirmed'] ==false){
              unConfirmedUsers.add(UserModel.formJson(element.data()));
            }

          }

          emit(GetUsersSuccessState());
    }).catchError((error){

      debugPrint('Error is ${error.toString()}');
      emit(GetUsersErrorState());
    });

  }


}