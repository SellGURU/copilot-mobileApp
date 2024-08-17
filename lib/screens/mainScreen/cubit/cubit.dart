import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:test_copilet/constants/endPoints.dart';

import 'state.dart';

class BiomarkerCubit extends Cubit<BiomarkerState> {
  BiomarkerCubit() : super(BiomarkerState()) {
    emit(LoggedOutState());
  }
  Dio _dio = Dio();
  getBiomarker() async {
    emit(LoadingState());
    try {
      await _dio.get(Endpoints.biomarker).then((value) {
        print(value);
        if (value.statusCode == 200) {
          emit(SuccessState());
        } else {
          emit(ErrorState());
        }
      });
    } catch (e) {
      emit(ErrorState());
    }
  }
}
