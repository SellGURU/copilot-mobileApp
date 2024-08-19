import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import 'state.dart';

class BiomarkerCubit extends Cubit<BiomarkerState> {
  BiomarkerCubit() : super(BiomarkerState()) {
    getBiomarker();
  }
  Dio _dio = Dio();
  Future<void> getBiomarker() async {
    emit(LoadingBiomarkerState());
    try {
      await _dio.get(Endpoints.biomarker).then((value) {
        print("status code:${value.statusCode}");
        if (value.statusCode == 200) {
          // var jsonResponse = json.decode(value.data);
          // print("data:${jsonResponse["data"]}");
          print("value.data:${value.data["data"]}");
          emit(SuccessBiomarkerState(biomarkerData: value.data));
        } else {
          emit(ErrorBiomarkerState());
        }
      });
    } catch (e) {
      print("full error $e");
      emit(ErrorBiomarkerState());
    }
  }
}
