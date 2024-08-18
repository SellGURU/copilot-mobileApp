import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_copilet/route/routes.dart';
import 'package:test_copilet/screens/home/cubit/cubit.dart';
import 'package:test_copilet/screens/login/cubit/cubit.dart';
import 'package:test_copilet/screens/login/login.dart';
import 'package:test_copilet/screens/login/cubit/state.dart';
import 'package:test_copilet/screens/mainScreen/mainScreen.dart';
import 'package:test_copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:test_copilet/utility/camareControlerBloc/camera_events.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/switchValueBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/token/getTokenLocaly.dart';
import 'package:test_copilet/utility/token/updateToken.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the cameras
  // final cameras = await availableCameras();
  // final camera = cameras.first;

  // runApp(MyApp(camera: camera));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
    // final CameraDescription camera;
    MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageIndexBloc()),
        BlocProvider(create: (_) => SwitchValueGraphBloc()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => BiomarkerCubit()),
        // if (Platform.isAndroid || Platform.isIOS)
        //   BlocProvider(
        //     lazy: false,
        //     create: (context) {
        //       // Create the CameraBlocBloc and immediately add the CameraInitialize event
        //       final cameraBloc = CameraBloc();
        //       cameraBloc.add(CameraInitialize(widget.camera));
        //       return cameraBloc;
        //     },
        //   ),
      ],
      child: MaterialApp(
        title: 'Copilot Demo',
        debugShowCheckedModeBanner: false,
        routes: routes,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (BuildContext context, state) {
            if (state is LoggedInState) {
              return const Mainscreen();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}
