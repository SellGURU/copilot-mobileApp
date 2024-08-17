import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'state.dart';

class BiomarkerCubit extends Cubit<BiomarkerState> {
  BiomarkerCubit() : super(BiomarkerState().init());
  Dio _dio=Dio();
  getBiomarker()async{
    emit(LoadingState());
    try{
      await _dio.get("");
    }catch(e){

    }
  }
}
