import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_events.dart';
import 'package:test_copilet/utility/changeScreanBloc/PageIndex_states.dart';

class PageIndexBloc extends Bloc<PageIndexEvents, PageIndexState> {
  PageIndexBloc() : super(PageIndexState(0)) {
    on<UpdatePageIndex>((event, emit) {
      state.pageIndex=event.pageIndex;
      return emit(PageIndexState(state.pageIndex));
    });
  }
}
