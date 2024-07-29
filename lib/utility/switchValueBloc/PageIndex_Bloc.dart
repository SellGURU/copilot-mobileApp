
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_copilet/utility/switchValueBloc/PageIndex_events.dart';
import 'package:test_copilet/utility/switchValueBloc/PageIndex_states.dart';

class SwitchValueGraphBloc extends Bloc<SwitchValueGraphEvent, SwitchValueState> {
  SwitchValueGraphBloc() : super(SwitchValueState(false)) {
    on<UpdateSwitchValueGraph>((event, emit) {
      state.switchValue=event.switchValue;
      return emit(SwitchValueState(state.switchValue));
    });
  }
}
