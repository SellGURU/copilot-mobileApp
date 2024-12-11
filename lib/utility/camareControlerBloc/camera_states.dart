/// This file defines the state of the camera, including the available cameras,
/// initialization status, and any potential error messages.
///
/// The state is represented by the [CameraStates] class, which is used by the
/// [CameraBloc] to emit updates based on camera-related events.
///
/// The class extends [Equatable] to ensure proper comparison of instances
/// based on the properties, which is useful for state management.

import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

/// A class representing the state of the camera, including the list of available cameras,
/// initialization status, and any error messages.
class CameraStates extends Equatable {
  /// The list of available cameras, if any. It is nullable as the cameras may not be initialized.
  final List<CameraDescription>? cameras;

  /// A boolean indicating whether the camera has been initialized.
  final bool isInitialized;

  /// An optional error message, if any error occurred during camera initialization or usage.
  final String? error;

  /// Constructor to initialize the [CameraStates] with optional parameters.
  const CameraStates({
    this.cameras,
    this.isInitialized = false,
    this.error,
  });

  /// A method that creates a copy of the current state with the option to modify certain fields.
  /// This is commonly used to create a new state object while keeping the existing state unchanged.
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

  /// Override the `props` getter from [Equatable] to return the properties that should be used
  /// for comparing instances of [CameraStates].
  @override
  List<Object?> get props => [cameras, isInitialized, error];
}
