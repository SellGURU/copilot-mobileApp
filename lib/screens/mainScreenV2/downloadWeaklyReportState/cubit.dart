import 'package:bloc/bloc.dart';

import 'state.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';

class DownloadWeaklyReportCubit extends Cubit<DownloadWeaklyReportState> {
  DownloadWeaklyReportCubit() : super(DownloadWeaklyReportState()) {
    getPdf();
  }
  final Dio _dio = Dio();
  Future<void> getPdf() async {
    print("check123");
    emit(LoadingDownloadWeaklyReportState());
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";

    try {
      _dio.post(Endpoints.downloadPdfReportWeakly,data: {
        "from_date": "2024-10-1",
        "to_date": "2024-10-7"
      }).then((res) {

        if(res.data!=null){
          print("res.data!=null");
          if(res.data is String)
          emit(SuccessDownloadWeaklyReportState(pdfUrlWeakly: res.data));
          else{
            emit(ErrorDownloadWeaklyReportState());
          }
          print("res.data: ttttt${res.data}");
        }
        else{
          print("pdf weakly be null");
          emit(ErrorDownloadWeaklyReportState());
        }
      });
    } catch (e) {
      print("error download pdf weakly $e");
      emit(ErrorDownloadWeaklyReportState());
    }
  }
}
