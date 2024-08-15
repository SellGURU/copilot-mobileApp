import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_copilet/res/colors.dart';

import '../../utility/camareControlerBloc/camera_Bloc.dart';
import '../../utility/camareControlerBloc/camera_events.dart';
import '../../utility/camareControlerBloc/camera_states.dart';

class CameraScreen extends StatelessWidget {
  // @override
  // void initState() async {
  //   final cameras = await availableCameras();
  //   final camera = cameras.first;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      body: BlocBuilder<CameraBlocBloc, CameraStates>(
        // create: (context) => CameraBlocBloc()..add(CameraInitialize(camera)),
        builder: (context, state) {
          if (state.isInitialized) {
            return Scaffold(
              appBar: AppBar(title: Text('Camera')),
              body: CameraPreview(state.controller!),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  context.read<CameraBlocBloc>().add(CameraCapture());
                },
                child: Icon(Icons.camera_alt),
              ),
            );
          } else if (state.error != null) {
            return Scaffold(
              appBar: AppBar(title: Text('Camera')),
              body: Center(child: Text(state.error!)),
            );
          } else {
            return Scaffold(
              appBar: AppBar(title: Text('Camera')),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
