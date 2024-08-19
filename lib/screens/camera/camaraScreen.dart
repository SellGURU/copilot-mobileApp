import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:copilet/utility/camareControlerBloc/camera_states.dart';

class CameraScreen extends StatefulWidget {
  late bool isCameraStart;
  CameraScreen({required this.isCameraStart});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Example background color
      body: BlocBuilder<CameraBloc, CameraStates>(
        builder: (context, state) {
          if (widget.isCameraStart) if (state.isInitialized &&
              state.cameras != null) {
            // Create a CameraController using the first available camera
            final cameraController = CameraController(
              state.cameras!.first,
              ResolutionPreset.high,
            );

            return FutureBuilder<void>(
              future: cameraController.initialize(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(cameraController);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement the camera capture or other functionality here
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
