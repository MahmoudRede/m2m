import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
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

  UserModel? userModel;
  static dynamic walletMoney = 0;

  Future<void>getUser()async{

    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get().then((value) {
      debugPrint('Get User Success');
      userModel=UserModel.fromMap(value.data()!);
      walletMoney = userModel!.wallet.money;
      debugPrint("user email ==> ${userModel!.email}   user wallet ==> $walletMoney");
      updateWalletState(walletMoney);
      getLastProfitState();
      emit(GetUserSuccessState());
    }).catchError((error){
      debugPrint('Error is ${error.toString()}');
      emit(GetUserErrorState());
    });

  }

  File? uploadedPaymentImage;
  var imagePicker = ImagePicker();

  Future <void> getPaymentImage() async {
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
            userImage: userModel!.profileImage.toString(),
            userUId: userModel!.uId.toString(),
            isVerified: false,
            packageName: "packageName",
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

  List<PaymentModel> paymentData =[];
  Future<void> getPaymentData ()async{
    emit(GetPaymentDataLoadingState());
    
    FirebaseFirestore.instance
        .collection('paymentImages')
        .get().then((value) {
          for (var element in value.docs) {
            paymentData.add(PaymentModel.fromMap(element.data()));
          }
          debugPrint("get payment data success ==> ${paymentData[0].paymentImage}");
          emit(GetPaymentDataSuccessState());
    }).catchError((error){
      debugPrint("Error when get payment data ==> ${error.toString()}");
      emit(GetPaymentDataErrorState());
    });
  }
  
  
  Future<void> confirmPayment ({
    required PaymentModel paymentModel
  })async{
    emit(ConfirmPaymentLoadingState());
    // get user data
    UserModel? userModel ;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(paymentModel.userUId.toString())
        .get()
        .then((value){
          userModel = UserModel.fromMap(value.data()!);
          debugPrint('payment user data ==> ${userModel!.username}');
          emit(GetUserSuccessState());
    })
        .catchError((error){
      debugPrint('Error when payment user data :${error.toString()}');
      emit(GetUserErrorState());
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(paymentModel.userUId.toString())
        .update({
      "package":{
        "packageName":userModel!.package.packageName.toString(),
        "packageId":userModel!.package.packageId.toString(),
        "isVerified":true,
      },
    }).then((value) async{
      await FirebaseFirestore.instance
          .collection('paymentImages')
          .doc(paymentModel.userUId.toString())
          .update({
        "isVerified": true,
      });
      debugPrint('Payment Confirmed successful');
      emit(ConfirmPaymentSuccessState());
    }).catchError((error){
      debugPrint('Error when confirm Payment ==> ${error.toString()}');
      emit(ConfirmPaymentErrorState());
    });
  }


  late String todayDate;
  late String yesterdayDate;
  final now = DateTime.now();

  Future<void> updateWalletState(wallet)async{
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
    }else{
      //SHOW SAME CONTENT
      String currentWallet = CashHelper.getData(key: CashHelper.lastWalletAmountKey).toString();
      debugPrint('my Current wallet is : $currentWallet');
    }

  }



  dynamic myWallet = 0;
  dynamic dayProfit = 0;

  Future<void> getLastProfitState()async{
    myWallet = CashHelper.getData(key: CashHelper.lastWalletAmountKey);
    dayProfit = walletMoney - myWallet;
    debugPrint("my current profit : $dayProfit");
    emit(GetLastProfitState());
  }





}