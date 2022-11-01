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
         required String month,
         required String year,
         required String userSkill1,
         required String userSkill2,
         required String userSkill3,
         required String userSkill4,
         required String userSkill5,
         required String userSkill6,
         required String userSkill7,
         required String userSkill8,
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
        month: month,
        year: year,
        userSkill1: userSills1,
        userSkill2: userSills2,
        userSkill3: userSills3,
        userSkill4: userSills4,
        userSkill5: userSills5,
        userSkill6: userSills6,
        userSkill7: userSills7,
        userSkill8: userSills8,
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
        String ?profileImage,
        required String personalImage,
        required String id,
        required String month,
        required String year,
        required String userSkill1,
        required String userSkill2,
        required String userSkill3,
        required String userSkill4,
        required String userSkill5,
        required String userSkill6,
        required String userSkill7,
        required String userSkill8,
      }
      )async{

      UserModel model =UserModel(
        email: email,
        phone: phone,
        username: name,
        nationalIdImage: nationalIdImage,
        personalImage: personalImage,
        uId: id,
        profileImage: profileImage??'https://firebasestorage.googleapis.com/v0/b/m2mapp-91014.appspot.com/o/user-svgrepo-com.png?alt=media&token=2a3faefa-613f-4d0e-a3b6-5b6556530ed7',
        package: Package(packageName: "not selected" , packageId: "id", isVerified: false),
        wallet: Wallet(money: 0.0 , point: 0.0),
        isConfirmed: false,
        age: age,
        month: month,
        year: year,
        government: government,
        skills: skills,
        userSkill1: userSills1,
        userSkill2: userSills2,
        userSkill3: userSills3,
        userSkill4: userSills4,
        userSkill5: userSills5,
        userSkill6: userSills6,
        userSkill7: userSills7,
        userSkill8: userSills8,
        inviteCode: inviteCode??''
      );

    emit(SaveInfoLoadingState());
    await FirebaseFirestore.instance.
    collection('users').doc(uId).set(model.toMap())
        .then((value) {

         debugPrint('Create User Success');
         emit(SaveInfoSuccessState());
    }).catchError((error){

      debugPrint('Error in Create User is ${error.toString()}');
      emit(SaveInfoErrorState());
    });

  }

  String governmentDropDown='' ;

  void changeGovernmentDropDown(value)
  {
    governmentDropDown = value ;
    emit(ChangeGovernmentDropDownState());
  }

  String userSills1='',userSills2='',userSills3='',userSills4='',userSills5='',userSills6='',userSills7='',userSills8='';

  bool selectSills1=false,selectSills2=false,selectSills3=false,selectSills4=false,selectSills5=false,selectSills6=false,selectSills7=false,selectSills8=false;


}