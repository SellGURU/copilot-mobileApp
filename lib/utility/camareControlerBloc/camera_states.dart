import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

class CameraStates extends Equatable {
  final List<CameraDescription>? cameras;
  final bool isInitialized;
  final String? error;

  const CameraStates({
    this.cameras,
    this.isInitialized = false,
    this.error,
  });

  CameraStates copyWith({
    List<CameraDescription>? cameras,
    bool? isInitialized,
    String? error,
  }) {
    return CameraStates(
      cameras: cameras ?? this.cameras,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [cameras, isInitialized, error];
}
