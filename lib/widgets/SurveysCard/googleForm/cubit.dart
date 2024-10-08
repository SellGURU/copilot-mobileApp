import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import 'state.dart';

class GoogleFormCubit extends Cubit<GoogleFormState> {
  GoogleFormCubit() : super(GoogleFormState()) {
    getBiomarker();
  }
  final Dio _dio = Dio();
  Future<void> getBiomarker() async {
    print("check GoogleFormState");
    emit(LoadingGoogleFormState());
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";

    try {
      print("url ${Endpoints.google_form}");
      _dio.post(Endpoints.google_form).then((res) {
        print("data:${res.toString()}");
        emit(SuccessGoogleFormState(googleFormData: res.data));
      });
    } catch (e) {
      print("error health score $e");
      emit(ErrorGoogleFormState());
    }
  }
}
