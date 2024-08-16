import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_copilet/res/colors.dart';

import '../../utility/camareControlerBloc/camera_Bloc.dart';
import '../../utility/camareControlerBloc/camera_events.dart';
import '../../utility/camareControlerBloc/camera_states.dart';

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraStates>(
      // create: (context) => CameraBlocBloc()..add(CameraInitialize(camera)),
      builder: (context, state) {
        if (state.isInitialized) {
          return Scaffold(
            backgroundColor: AppColors.bgScreen,
            body: CameraPreview(state.controller!),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<CameraBloc>().add(CameraCapture());
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
    );
  }
}
