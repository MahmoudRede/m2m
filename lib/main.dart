import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:m2m/Data/core/local/cash_helper.dart';
import 'package:m2m/Presentation/screens/login_screen/screen/login_screen.dart';
import 'package:m2m/Presentation/screens/on_boarding_screen/screen/on_boarding_screen.dart';
import 'package:m2m/Presentation/screens/package_screen/screen/package_screen.dart';
import 'package:m2m/Presentation/screens/splash_screen/screen/splash_screen.dart';
import 'package:m2m/Presentation/styles/color_manager.dart';
import 'package:m2m/business_logic/app_cubit/app_cubit.dart';
import 'package:m2m/business_logic/app_localization.dart';
import 'package:m2m/business_logic/localization_cubit/localization_cubit.dart';
import 'package:m2m/business_logic/localization_cubit/localization_states.dart';
import 'package:m2m/business_logic/login_cubit/login_cubit.dart';
import 'package:m2m/business_logic/payment_cubit/payment_cubit.dart';
import 'package:m2m/business_logic/register_cubit/register_cubit.dart';
import 'package:m2m/business_logic/tasks_cubit/tasks_cubit.dart';
import 'package:m2m/constants/constants.dart';
import 'package:m2m/firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CashHelper.init();

  String languageCode = CashHelper.getData(key: CashHelper.languageKey).toString();
  debugPrint('language code is : $languageCode');

  uId = CashHelper.getData(key: 'uId');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()..getUser()..getUsers()..getCourse()),
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => PaymentCubit()..getUser()..getPaymentData()),
        BlocProvider(create: (BuildContext context) => TasksCubit()..getUser()),
        BlocProvider(create: (BuildContext context) => LocalizationCubit()..fetchLocalization()),
      ],
      child: BlocConsumer<LocalizationCubit,LocalizationStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'M2M',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: ColorManager.white,
              appBarTheme: AppBarTheme(
                backgroundColor: ColorManager.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: ColorManager.black,
                ),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
              ),
            ),
            home: const SplashScreen(),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en",""),
              Locale("ar",""),
            ],
            locale: LocalizationCubit.get(context).appLocal,
            localeResolutionCallback: (currentLang , supportLang){
              if(currentLang != null) {
                for(Locale locale in supportLang){
                  if(locale.languageCode == currentLang.languageCode){
                    return currentLang;
                  }
                }
              }
              return supportLang.first;
            },
          );
        },
      ),
    );
  }
}

