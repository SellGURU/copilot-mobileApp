import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import 'state.dart';

/// The `BiomarkerCubit` class handles the logic of fetching biomarker data and managing states related to biomarker fetching.
class BiomarkerCubit extends Cubit<BiomarkerState> {
  // Constructor initializes the BiomarkerCubit and fetches biomarker data on creation
  BiomarkerCubit() : super(BiomarkerState()) {
    getBiomarker();
  }

  Dio _dio = Dio(); // Instance of Dio for making HTTP requests

  /// Fetches the biomarker data from the endpoint and updates the state accordingly.
  Future<void> getBiomarker() async {
    emit(LoadingBiomarkerState()); // Emit loading state before making the request
    try {
      await _dio.get(Endpoints.biomarker).then((value) {
        // Handle the response based on the status code
        if (value.statusCode == 200) {
          // If the response is successful (status code 200), emit success state with the data
          print("value.data:${value.data["data"]}");
          emit(SuccessBiomarkerState(biomarkerData: value.data));
        } else {
          // If the response status code is not 200, emit an error state
          emit(ErrorBiomarkerState());
        }
      });
    } catch (e) {
      // If an exception occurs, emit an error state
      emit(ErrorBiomarkerState());
    }
  }
}
