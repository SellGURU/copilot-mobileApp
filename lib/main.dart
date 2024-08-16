import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_copilet/route/routes.dart';
import 'package:test_copilet/screens/mainScreen/mainScreen.dart';
import 'package:test_copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:test_copilet/utility/camareControlerBloc/camera_events.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/switchValueBloc/PageIndex_Bloc.dart';
import 'package:test_copilet/utility/token/updateToken.dart';
// import 'dart:io'; // Import this to use the Platform class
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'camera_bloc.dart';  // Import your CameraBloc
// import 'mainscreen.dart';  // Import your main screen
// import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UpdateToken("token");

  // Initialize the cameras
  final cameras = await availableCameras();
  final camera = cameras.first;

  runApp(MyApp(camera: camera));
}

class MyApp extends StatefulWidget {
  final CameraDescription camera;

  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Copilot Demo',
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageIndexBloc()),
          BlocProvider(create: (_) => SwitchValueGraphBloc()),
          if (Platform.isAndroid || Platform.isIOS)
            BlocProvider(
              lazy: false,
              create: (context) {
                // Create the CameraBlocBloc and immediately add the CameraInitialize event
                final cameraBloc = CameraBloc();
                cameraBloc.add(CameraInitialize(widget.camera));
                return cameraBloc;
              },
            ),
        ],
        child: const Mainscreen(),
      ),
    );
  }
}
