import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'camera_events.dart';
import 'camera_states.dart';

class CameraBloc extends Bloc<CameraEvents, CameraStates> {
  CameraBloc() : super(CameraStates()) {
    // Event to initialize and store available cameras
    on<CameraInitialize>((event, emit) async {
      try {
        final cameras = await availableCameras();  // Fetch available cameras
        emit(CameraStates(cameras: cameras, isInitialized: true));
      } catch (e) {
        emit(CameraStates(error: 'Failed to initialize cameras: $e'));
      }
    });

    // Event to dispose of any resources if needed
    on<CameraDispose>((event, emit) async {
      emit(CameraStates()); // Reset the state
    });
  }
}
