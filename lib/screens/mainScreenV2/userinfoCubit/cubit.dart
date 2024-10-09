import 'package:bloc/bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import 'state.dart';

class ClientInformationMobileCubit extends Cubit<ClientInformationMobileState> {
  ClientInformationMobileCubit() : super(ClientInformationMobileState()) {
    getPdf();
  }
  final Dio _dio = Dio();
  Future<void> getPdf() async {
    print("check123");
    emit(LoadingClientInformationMobileState());
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";

    try {
      _dio.post(Endpoints.clientInformationMobile).then((res) {
        if(res.data!=null){
          emit(SuccessClientInformation(userInfo: res.data));
          print("res.data info:${res.data}");
        }
        else{
          // print("pdf be null");
          emit(ErrorClientInformationMobileState());
        }
      });
    } catch (e) {
      print("error info $e");
      emit(ErrorClientInformationMobileState());
    }
  }
  Future<void> refresh() async {
    print("Refreshing data...");
    await getPdf(); // Call the same method to refresh
  }
}
