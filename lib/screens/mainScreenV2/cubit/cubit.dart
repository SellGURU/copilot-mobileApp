import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import 'state.dart';

class HealthScoreCubit extends Cubit<HealthScoreState> {
  HealthScoreCubit() : super(HealthScoreState()) {
    getBiomarker();
  }
  final Dio _dio = Dio();
  Future<void> getBiomarker() async {
    if(state is!  SuccessHealthScore){
      // print("check1");
      emit(LoadingHealthScore());
      var token = await getTokenLocally();
      _dio.options.headers['Authorization'] = "bearer $token";

      try {
        // print("url ${Endpoints.healthScore}");
        _dio.post(Endpoints.healthScore).then((res) {
          // print("data:${res.toString()}");
          emit(SuccessHealthScore(scoreData: res.data));
        });
      } catch (e) {
        print("error health score $e");
        emit(ErrorHealthScore());
      }
    }
    }

}
