import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import 'state.dart';

class DownloadReportPdfCubit extends Cubit<DownloadPdfState> {
  
  DownloadReportPdfCubit() : super(DownloadPdfState()) {
    getPdf();
  }
  
  final Dio _dio = Dio();
  
  Future<void> getPdf() async {
    if(state is! SuccessDownloadPdf){
      // print("check12");
      emit(LoadingDownloadPdf());
      var token = await getTokenLocally();
      _dio.options.headers['Authorization'] = "bearer $token";

      // Get stored user ID from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedUserId = prefs.getString('userInfoid');
      
      if (storedUserId != null) {
        String userId = jsonDecode(storedUserId);
        String pdfUrl = "https://holisticare.vercel.app/share/$userId/ZXCVMNBBASDFLKJHRTYU";
        emit(SuccessDownloadPdf(pdfUrl: pdfUrl));
      } else {
        emit(ErrorDownloadPdf());
      }
    }
  }
}
