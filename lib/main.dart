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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Update the token
  await UpdateToken("token");
  // Get available cameras
  if (Platform.isAndroid || Platform.isIOS) {
    final cameras = await availableCameras();
    final camera = cameras.first;
    runApp(MyApp(camera: camera));
  }
}

class MyApp extends StatefulWidget {
  final CameraDescription camera;

  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pageIndex = 0;
  bool contishen = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'copilot demo',
      debugShowCheckedModeBanner: false,
      routes: routes,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => PageIndexBloc()),
          BlocProvider(create: (_) => SwitchValueGraphBloc()),
         // Platform.isAndroid || Platform.isIOS) ?
          BlocProvider(
            create: (context) {
              // Create the CameraBlocBloc and immediately add the CameraInitialize event
              final cameraBloc = CameraBlocBloc();
              cameraBloc.add(CameraInitialize(widget.camera));
              return cameraBloc;
            },
          ),:""
        ],
        child: const Mainscreen(),
      ),
    );
  }
}
