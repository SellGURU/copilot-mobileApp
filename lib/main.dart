import 'package:camera/camera.dart';
import 'package:copilet/screens/onBoardingLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:copilet/route/routes.dart';
import 'package:copilet/screens/home/cubit/cubit.dart';
import 'package:copilet/screens/login/cubit/cubit.dart';
import 'package:copilet/screens/login/cubit/state.dart';
import 'package:copilet/screens/login/login.dart';
import 'package:copilet/screens/mainScreen/mainScreen.dart';
import 'package:copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:copilet/utility/camareControlerBloc/camera_events.dart';
import 'package:copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:copilet/utility/switchValueBloc/PageIndex_Bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // چک کردن اینکه آیا کاربر قبلاً صفحه‌ی Onboarding را دیده یا نه
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime; // اضافه کردن این پارامتر برای مدیریت صفحه‌ی Onboarding

  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageIndexBloc()),
        BlocProvider(create: (_) => SwitchValueGraphBloc()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => BiomarkerCubit()),
        BlocProvider(
          lazy: false,
          create: (context) {
            final cameraBloc = CameraBloc();
            cameraBloc.add(CameraInitialize()); // شروع مقداردهی اولیه
            return cameraBloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Copilot Demo',
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: isFirstTime ? onboarddinglogin() : AuthHandler(), // چک کردن فلگ اولین بار
      ),
    );
  }
}

class AuthHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          return const Mainscreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
