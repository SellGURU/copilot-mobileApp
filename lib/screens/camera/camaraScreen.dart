import 'dart:convert';
import 'dart:io';
import 'package:copilet/route/names.dart';
import 'package:copilet/screens/camera/imageHandlerCubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:copilet/utility/camareControlerBloc/camera_Bloc.dart';
import 'package:copilet/utility/camareControlerBloc/camera_states.dart';

import '../chatScreen/chatScreen.dart';

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

  Future<void> _captureAndConvertToBase64() async {
    try {
      if (_cameraController == null ||
          !_cameraController!.value.isInitialized) {
        print("Camera is not initialized");
        return;
      }

      // Capture the image and store it in a temporary file
      final XFile imageFile = await _cameraController!.takePicture();

      // Convert the image file to bytes
      final File file = File(imageFile.path);
      final bytes = await file.readAsBytes();

      // Encode the bytes as a base64 string
      final base64String = base64Encode(bytes);

      // Print or use the base64 string
      // print("Base64 String: $base64String");
      // Navigator.pushNamed(context, ScreenNames.)
      BlocProvider.of<ImageHandlerCubitCubit>(context).getImage(base64String);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const Chatscreen()));
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Example background color
      body: widget.isCameraStart
          ? _cameraController != null && _cameraController!.value.isInitialized
              ? CameraPreview(_cameraController!)
              : const Center(child: CircularProgressIndicator())
          : const Center(child: Text('Camera is not started')),
      floatingActionButton: widget.isCameraStart
          ? FloatingActionButton(
              onPressed: _captureAndConvertToBase64,
              child: Icon(Icons.camera_alt),
            )
          : null,
    );
  }
}
