import 'package:camera/camera.dart';

class CameraStates {
  final CameraController? controller;
  final bool isInitialized;
  final String? imagePath;
  final String? error;

  CameraStates({
    this.controller,
    this.isInitialized = false,
    this.imagePath,
    this.error,
  });

  CameraStates copyWith({
    CameraController? controller,
    bool? isInitialized,
    String? imagePath,
    String? error,
  }) {
    return CameraStates(
      controller: controller ?? this.controller,
      isInitialized: isInitialized ?? this.isInitialized,
      imagePath: imagePath ?? this.imagePath,
      error: error ?? this.error,
    );
  }
}
