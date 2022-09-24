import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:m2m/business_logic/app_cubit/app_states.dart';

class AppCubit extends Cubit<AppState>{

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);


}