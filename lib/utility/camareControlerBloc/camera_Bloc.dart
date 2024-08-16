import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'camera_events.dart';
import 'camera_states.dart';

class CameraBloc extends Bloc<CameraEvents, CameraStates> {
  CameraBloc() : super(CameraStates()) {
    on<CameraInitialize>((event, emit) async {
      try {
        final controller = CameraController(
          event.camera,
          ResolutionPreset.high,
        );
        await controller.initialize();
        emit(CameraStates(controller: controller, isInitialized: true));
      } catch (e) {
        emit(CameraStates(error: 'Failed to initialize camera: $e'));
      }
    });

    on<CameraCapture>((event, emit) async {
      if (state.isInitialized && state.controller != null) {
        try {
          final image = await state.controller!.takePicture();
          final directory = await getApplicationDocumentsDirectory();
          final filePath = path.join(directory.path, '${DateTime.now()}.png');
          await image.saveTo(filePath);

          emit(state.copyWith(imagePath: filePath));
        } catch (e) {
          emit(state.copyWith(error: 'Failed to capture image: $e'));
        }
      }
    });

    on<CameraDispose>((event, emit) async {
      try {
        await state.controller?.dispose();
        emit(CameraStates());
      } catch (e) {
        emit(state.copyWith(error: 'Failed to dispose camera: $e'));
      }
    });
  }
}
