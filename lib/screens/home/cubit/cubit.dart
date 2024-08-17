import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import 'state.dart';

class BiomarkerCubit extends Cubit<BiomarkerState> {
  BiomarkerCubit() : super(BiomarkerState()){
    getBiomarker();
  }
  Dio _dio = Dio();
  getBiomarker() async {
    emit(LoadingBiomarkerState());
    try {
      await _dio.get(Endpoints.biomarker).then((value) {
        print(value);
        if (value.statusCode == 200) {
          print(value.data);
          emit(SuccessBiomarkerState(biomarkerData: value.data));
        } else {
          emit(ErrorBiomarkerState());
        }
      });
    } catch (e) {
      emit(ErrorBiomarkerState());
    }
  }
}
