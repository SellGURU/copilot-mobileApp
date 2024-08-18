import 'package:flutter_bloc/flutter_bloc.dart';

import 'PageIndex_events.dart';
import 'PageIndex_states.dart';


class PageIndexBloc extends Bloc<PageIndexEvents, PageIndexState> {
  PageIndexBloc() : super(PageIndexState(0)) {
    on<UpdatePageIndex>((event, emit) {
      state.pageIndex=event.pageIndex;
      return emit(PageIndexState(state.pageIndex));
    });
  }
}
