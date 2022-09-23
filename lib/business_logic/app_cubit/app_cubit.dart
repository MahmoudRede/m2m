import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppState>{

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  File? uploadedNationalCard ;
  var picker = ImagePicker();

  Future <void> getNationalCard() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadedNationalCard = File(pickedFile.path);
      emit(PickNationalCardSuccessState());
    } else {
      print('No Image selected.');
      emit(PickNationalCardErrorState());
    }
  }

  File? uploadedPersonalImage ;
  var picker2 = ImagePicker();

  Future <void> getPersonalImage() async {
    final pickedFile = await picker2.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      uploadedPersonalImage = File(pickedFile.path);
      emit(PickPersonalImageSuccessState());
    } else {
      print('No Image selected.');
      emit(PickPersonalImageErrorState());
    }
  }
}