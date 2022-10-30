import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/business_logic/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel ?userModel;
  Future<void> userLogin ({
          required String email,
          required String password,
       })async{

    emit(UserLoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      debugPrint('Login Success');

      emit(UserLoginSuccessState(value.user!.uid));

    }).catchError((error){

      debugPrint('Error in user login is ${error.toString()}');
      emit(UserLoginErrorState());
    });

  }


}