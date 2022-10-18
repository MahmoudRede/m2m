import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
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
      debugPrint('No Image selected.');
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

        CashHelper.saveData(key: 'nationalId',value: value);

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
      debugPrint('pick image');
      emit(PickPersonalImageSuccessState());
    } else {
      debugPrint('No Image selected.');
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

       CashHelper.saveData(key: 'personalImage',value: value);

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
         required String age,
         required String government,
         required String skills,
         required String nationalIdImage,
         required String personalImage,
         String ?inviteCode,

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
        id: uId!,
        government: government,
        nationalIdImage: nationalIdImage,
        personalImage: personalImage,
        skills: skills,
        age: age,
        inviteCode: inviteCode,
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
        required String age,
        required String skills,
        required String government,
        required String nationalIdImage,
        String ?inviteCode,
        required String personalImage,
        required String id,
        String ?package,
      }
      )async{

      UserModel model =UserModel(
        email: email,
        phone: phone,
        username: name,
        nationalIdImage: nationalIdImage,
        personalImage: personalImage,
        uId: id,
        package: package??'not selected yet',
        isConfirmed: false,
        age: age,
        government: government,
        skills: skills,
        inviteCode: inviteCode??''
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