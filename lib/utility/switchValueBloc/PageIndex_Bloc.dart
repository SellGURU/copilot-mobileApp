/// This file defines the [SwitchValueGraphBloc], which is responsible for managing the
/// state of a switch value in a Flutter application.
///
/// The [SwitchValueGraphBloc] listens for events related to updating the switch value
/// and emits a new state based on the received event.
///
/// The BLoC pattern is used to separate the logic of handling switch value events from the UI.

import 'package:flutter_bloc/flutter_bloc.dart';

import 'PageIndex_events.dart';
import 'PageIndex_states.dart';

/// A BLoC class that handles switch value events and emits corresponding states.
class SwitchValueGraphBloc extends Bloc<SwitchValueGraphEvent, SwitchValueState> {
  /// Constructor to initialize the [SwitchValueGraphBloc] with the initial state.
  /// The initial state is set to [SwitchValueState(false)] indicating that the switch value is initially false.
  SwitchValueGraphBloc() : super(SwitchValueState(false)) {
    // Event to update the current switch value
    on<UpdateSwitchValueGraph>((event, emit) {
      // Update the switch value in the state with the new value from the event
      state.switchValue = event.switchValue;
      // Emit the new state with the updated switch value
      return emit(SwitchValueState(state.switchValue));
    });
  }
}
