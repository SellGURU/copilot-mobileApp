import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:copilet/utility/camareControlerBloc/camera_states.dart';

class CameraScreen extends StatefulWidget {
  final bool isCameraStart;

  CameraScreen({required this.isCameraStart});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    if (widget.isCameraStart) {
      _initializeCamera();
    }
  }

  void _initializeCamera() {
    final cameraBloc = BlocProvider.of<CameraBloc>(context);
    final state = cameraBloc.state;

    if (state.isInitialized && state.cameras != null) {
      _cameraController = CameraController(
        state.cameras!.first,
        ResolutionPreset.high,
      );

      _cameraController?.initialize().then((_) {
        if (!mounted) return;
        setState(() {}); // Refresh the UI when the controller is initialized
      });
    }
  }

  @override
  void dispose() {
    // Dispose of the CameraController when the screen is disposed
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 00
    return Scaffold(
      backgroundColor: Colors.grey[900], // Example background color
      body: widget.isCameraStart
          ? _cameraController != null &&
                  _cameraController!.value.isInitialized
              ? CameraPreview(_cameraController!)
              : Center(child: CircularProgressIndicator())
          : Center(child: Text('Camera is not started')),
      floatingActionButton: widget.isCameraStart
          ? FloatingActionButton(
              onPressed: () {
                // Implement the camera capture or other functionality here
              },
              child: Icon(Icons.camera_alt),
            )
          : null,
    );
  }
}
