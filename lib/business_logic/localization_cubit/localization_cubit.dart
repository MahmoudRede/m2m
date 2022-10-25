import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/business_logic/localization_cubit/localization_states.dart';

class LocalizationCubit extends Cubit<LocalizationStates>{

  LocalizationCubit() : super(InitialState());

  static LocalizationCubit get(context) => BlocProvider.of(context);

  Locale _appLocale = const Locale('en');

  Locale get appLocal => _appLocale;

  Future<void> fetchLocalization()async{
    String languageCode = CashHelper.getData(key: CashHelper.languageKey).toString();

    if(languageCode == 'null'){
      CashHelper.saveData(key: CashHelper.languageKey,value: "en");
      _appLocale = const Locale("en");
      changeLanguage(code: "en");
      emit(FetchLocalizationState());
    }
    else{
      _appLocale = Locale(languageCode);
      emit(FetchLocalizationState());
    }
    emit(FetchLocalizationState());
  }




  Future<void> changeLanguage({required String code})async{
    switch(code){
      case "ar":{
        _appLocale = const Locale("ar");
        CashHelper.saveData(key: CashHelper.languageKey,value: "ar");
        debugPrint('App language is Arabic');
        emit(ChangeToArabicState());
      }
      break;
      case "en":{
        _appLocale = const Locale("en");
        CashHelper.saveData(key: CashHelper.languageKey,value: "en");
        debugPrint('App language is English');
        emit(ChangeToEnglishState());
      }
      break;
    }
    emit(ChangeLanguageState());
  }



}