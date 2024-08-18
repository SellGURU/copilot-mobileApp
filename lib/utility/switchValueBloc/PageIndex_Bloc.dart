
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PageIndex_events.dart';
import 'PageIndex_states.dart';

class SwitchValueGraphBloc extends Bloc<SwitchValueGraphEvent, SwitchValueState> {
  SwitchValueGraphBloc() : super(SwitchValueState(false)) {
    on<UpdateSwitchValueGraph>((event, emit) {
      state.switchValue=event.switchValue;
      return emit(SwitchValueState(state.switchValue));
    });
  }
}
