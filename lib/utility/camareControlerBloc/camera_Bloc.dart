/// This file defines the [CameraBloc], which manages the state of the camera.
/// It listens to events related to the camera and updates the state accordingly.
///
/// The BLoC pattern is used to separate the logic of handling camera events from the UI.
/// [CameraBloc] listens for events such as initializing the camera and disposing of resources.

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'camera_events.dart';
import 'camera_states.dart';

/// A BLoC class that handles camera-related events and emits corresponding states.
class CameraBloc extends Bloc<CameraEvents, CameraStates> {
  /// Constructor to initialize the [CameraBloc] with the initial state.
  CameraBloc() : super(CameraStates()) {
    // Event to initialize and store available cameras
    on<CameraInitialize>((event, emit) async {
      try {
        final cameras = await availableCameras();  // Fetch available cameras
        // Emit state with available cameras and initialization status
        emit(CameraStates(cameras: cameras, isInitialized: true));
      } catch (e) {
        // Emit state with error message if camera initialization fails
        emit(CameraStates(error: 'Failed to initialize cameras: $e'));
      }
    });

    // Event to dispose of any resources if needed
    on<CameraDispose>((event, emit) async {
      // Reset the state by emitting the initial state
      emit(CameraStates());
    });
  }
}
