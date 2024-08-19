import 'package:equatable/equatable.dart';

abstract class CameraEvents extends Equatable {
  const CameraEvents();

  @override
  List<Object?> get props => [];
}

class CameraInitialize extends CameraEvents {}

class CameraDispose extends CameraEvents {}
