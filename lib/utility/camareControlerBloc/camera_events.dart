import 'package:camera/camera.dart';

abstract class CameraEvents {}

class CameraInitialize extends CameraEvents {
  final CameraDescription camera;

  CameraInitialize(this.camera);
}

class CameraCapture extends CameraEvents {}

class CameraDispose extends CameraEvents {}
