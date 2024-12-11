/// This file defines the events related to the camera in a Flutter application.
///
/// It uses the `Equatable` package to ensure that events are properly compared for equality.
/// This is useful for state management libraries like BLoC, where comparing events efficiently
/// is necessary for determining whether a new event has occurred.

import 'package:equatable/equatable.dart';

/// Abstract base class for camera events, extending [Equatable] to ensure correct comparison of events.
abstract class CameraEvents extends Equatable {
  const CameraEvents();

  /// Override the `props` getter to provide a list of properties that should be used for event comparison.
  /// Since this base class has no properties, it returns an empty list.
  @override
  List<Object?> get props => [];
}

/// Event for initializing the camera.
class CameraInitialize extends CameraEvents {}

/// Event for disposing of the camera resources.
class CameraDispose extends CameraEvents {}
