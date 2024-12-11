/// This file defines the [PageIndexBloc], which is responsible for managing the
/// page index state in a Flutter application.
///
/// The [PageIndexBloc] listens for events related to updating the page index
/// and emits a new state based on the received event.
///
/// The BLoC pattern is used to separate the logic of handling page index events from the UI.

import 'package:flutter_bloc/flutter_bloc.dart';

import 'PageIndex_events.dart';
import 'PageIndex_states.dart';

/// A BLoC class that handles page index events and emits corresponding states.
class PageIndexBloc extends Bloc<PageIndexEvents, PageIndexState> {
  /// Constructor to initialize the [PageIndexBloc] with the initial state.
  /// The initial state is set to [PageIndexState(0)] indicating that the initial page index is 0.
  PageIndexBloc() : super(PageIndexState(0)) {
    // Event to update the current page index
    on<UpdatePageIndex>((event, emit) {
      // Update the page index in the state with the new value from the event
      state.pageIndex = event.pageIndex;
      // Emit the new state with the updated page index
      return emit(PageIndexState(state.pageIndex));
    });
  }
}
