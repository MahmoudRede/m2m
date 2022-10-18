import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  File? uploadedTaskImage ;
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


  Future <void> urlLunch({required String taskLink})async
  {
    String url= taskLink;
    await launch(url , forceSafariVC: false);
    emit(UrlLaunchState());
  }


}