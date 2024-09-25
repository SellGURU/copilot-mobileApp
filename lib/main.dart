import 'package:camera/camera.dart';
import 'package:copilet/screens/MainScreenV2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            cameraBloc.add(CameraInitialize()); // Trigger initialization
            return cameraBloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Copilot Demo',
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return const Mainscreenv2();
              // return const LoginPage();

            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
