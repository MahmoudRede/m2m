import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/business_logic/register_cubit/register_state.dart';
import 'package:m2m/constants/constants.dart';

class RegisterCubit extends Cubit<RegisterState>{

  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);


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

  Future uploadNationalIdImage(){

    emit(UploadNationalIdLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('nationalId/${Uri.file(uploadedNationalCard!.path).pathSegments.last}')
        .putFile(uploadedNationalCard!).then((value) {

      value.ref.getDownloadURL().then((value) {

        debugPrint('uploadedNationalCard Success');

        FirebaseFirestore.instance.collection('users').doc(uId).update(
          {
            'nationalIdImage':value
          }
        ).then((value) {
          debugPrint('nationalIdImage update done');
        });
       
        emit(UploadNationalIdSuccessState());

      }).catchError((error){

        debugPrint('Error in Upload NationalId ${error.toString()}');
        emit(UploadNationalIdErrorState());

      });

    }).catchError((error){

      debugPrint('Error in Upload NationalId ${error.toString()}');
      emit(UploadNationalIdErrorState());
    });


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

  Future uploadPersonalImage(){

    emit(UploadPersonalImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
        .child('personalImage/${Uri.file(uploadedPersonalImage!.path).pathSegments.last}')
        .putFile(uploadedPersonalImage!).then((value) {

      value.ref.getDownloadURL().then((value) {

        debugPrint('uploadedPersonalImage Success');

        FirebaseFirestore.instance.collection('users').doc(uId).update(
            {
              'personalImage':value
            }
        ).then((value) {
          debugPrint('personalImage update done');
        });

        emit(UploadPersonalImageSuccessState());

      }).catchError((error){

        debugPrint('Error in Upload PersonalImage ${error.toString()}');
        emit(UploadPersonalImageErrorState());

      });

    }).catchError((error){

      debugPrint('Error in Upload PersonalImage ${error.toString()}');
      emit(UploadPersonalImageErrorState());
    });


  }


  Future<void> userRegister(
      {
         required String email,
         required String pass,
         required String name,
         required String phone,

      }
      )async{

    emit(UserRegisterLoadingState());
    await FirebaseAuth.instance.
    createUserWithEmailAndPassword(
        email: email,
        password: pass
    ).then((value) {

      debugPrint('User Register');
      uId=value.user!.uid;

      saveUserInfo(
          email: email,
          name: name,
          phone: phone,
          id: uId,
      );
      emit(UserRegisterSuccessState());
    }).catchError((error){

      debugPrint('Error in Crete User is ${error.toString()}');
      emit(UserRegisterErrorState());
    });

  }

  Future<void> saveUserInfo(
      {
        required String email,
        required String name,
        required String phone,
        String ?nationalIdImage,
        String ?personalImage,
        required String id,
        String ?package,
      }
      )async{

      UserModel model =UserModel(
        email: email,
        phone: phone,
        username: name,
        nationalIdImage: nationalIdImage??'',
        personalImage: personalImage??'',
        uId: id,
        package: package??'not selected yet'
      );

    emit(SaveInfoLoadingState());
    await FirebaseFirestore.instance.
    collection('users').doc(uId).set(model.toMap())
        .then((value) {

         debugPrint('Create User Success');
         emit(UserRegisterSuccessState());
    }).catchError((error){

      debugPrint('Error in Crete User is ${error.toString()}');
      emit(UserRegisterErrorState());
    });

  }

}