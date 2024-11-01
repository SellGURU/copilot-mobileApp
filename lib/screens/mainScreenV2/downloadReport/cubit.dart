import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import 'state.dart';


class DownloadReportPdfCubit extends Cubit<DownloadPdfState> {
  DownloadReportPdfCubit() : super(DownloadPdfState()) {
    getPdf();
  }
  final Dio _dio = Dio();
  Future<void> getPdf() async {
    if(state is SuccessDownloadPdf){
      print("check12");
      emit(LoadingDownloadPdf());
      var token = await getTokenLocally();
      _dio.options.headers['Authorization'] = "bearer $token";

      try {
        _dio.post(Endpoints.downloadPdfReport).then((res) {
          if(res.data!=null){
            emit(SuccessDownloadPdf(pdfUrl: res.data));
            print("res.data:${res.data}");
          }
          else{
            print("pdf be null");
            emit(ErrorDownloadPdf());
          }
        });
      } catch (e) {
        print("error download pdf $e");
        emit(ErrorDownloadPdf());
      }
    }
    }

}
