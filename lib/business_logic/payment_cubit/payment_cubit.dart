import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m2m/Data/model/payment_model.dart';
import 'package:m2m/Data/model/user_model.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/Presentation/widgets/custom_toast.dart';
import 'package:m2m/business_logic/payment_cubit/payment_states.dart';
import 'package:m2m/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentCubit extends Cubit<PaymentStates>{

  PaymentCubit() : super(InitialState());

  static PaymentCubit get(context) => BlocProvider.of(context);

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

  File? uploadedPaymentImage;
  var imagePicker = ImagePicker();

  Future <void> getTaskImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadedPaymentImage = File(pickedFile.path);
      emit(UploadImageSuccessState());
    } else {
      print('No Image selected.');
      emit(UploadImageErrorState());
    }
  }


  Future <void> urlLunch({required String paymentLink}) async {
    String url= paymentLink;
    await launch(url , forceSafariVC: false);
    emit(UrlLaunchState());
  }


  Future<void> uploadPaymentImage ()async
  {
    await getUser();
    emit(UploadPaymentImageLoadingState());
    FirebaseStorage.instance.ref()
        .child('paymentImages/${Uri.file(uploadedPaymentImage!.path)
        .pathSegments.last}').putFile(uploadedPaymentImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        // upload payment model data
        final PaymentModel paymentModel = PaymentModel(
            packageId: 'packageId',
            paymentImage: value.toString(),
            userName: userModel!.username.toString(),
            userImage: userModel!.personalImage.toString(),
            userUId: userModel!.uId.toString(),
            isVerified: false,
            packageName: userModel!.package.toString(),
            userPhone: userModel!.phone.toString(),
        );

        FirebaseFirestore.instance.collection('paymentImages').doc(userModel!.uId.toString()).set(paymentModel.toMap())
            .then((value){
          if (kDebugMode) {
            print('payment image Added Successfully');
          }
          emit(UploadPaymentImageSuccessState());
        }).catchError((error){
          if (kDebugMode) {
            print('Error When upload payment image : ${error.toString()}');
          }
          customToast(title: 'Sorry time is out try again', color: ColorManager.red);
          emit(UploadPaymentImageErrorState());
        });
      }).catchError((error){
        if (kDebugMode) {
          print('Error When get upload payment image link : ${error.toString()}');
        }
        customToast(title: 'Sorry time is out try again', color: ColorManager.red);
        emit(UploadPaymentImageErrorState());
      });
    }).catchError((error){
      if (kDebugMode) {
        print('Error When Upload image in Firesorage : ${error.toString()}');
      }
      customToast(title: 'Sorry time is out try again', color: ColorManager.red);
      emit(UploadPaymentImageErrorState());
    });
  }



}