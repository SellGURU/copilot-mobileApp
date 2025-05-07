import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import 'state.dart';

/// The `BiomarkerCubit` class handles the logic of fetching biomarker data and managing states related to biomarker fetching.
class BiomarkerCubit extends Cubit<BiomarkerState> {
  // Constructor initializes the BiomarkerCubit and fetches biomarker data on creation
  BiomarkerCubit() : super(BiomarkerState()) {
    getBiomarker();
  }

  Dio _dio = Dio(); // Instance of Dio for making HTTP requests
  List<Map<String, dynamic>> getAllBiomarkers(Map<String, dynamic> data) {
    List<Map<String, dynamic>> allBiomarkers = [];
    // Check if data has categories
    if (data.containsKey('categories')) {
      // Iterate through each category
      for (var category in data['categories']) {
        // Check if category has subcategories
        if (category.containsKey('subcategories')) {
          // Iterate through each subcategory
          for (var subcategory in category['subcategories']) {
            // Check if subcategory has biomarkers
            if (subcategory.containsKey('biomarkers')) {
              // Add all biomarkers to the result list
              allBiomarkers.addAll(
                List<Map<String, dynamic>>.from(subcategory['biomarkers'])
              );
            }
          }
        }
      }
    }
    print("All biomarkers: ${allBiomarkers}");
    return allBiomarkers;
  }
  /// Fetches the biomarker data from the endpoint and updates the state accordingly.
  Future<void> getBiomarker() async {
    emit(LoadingBiomarkerState()); // Emit loading state before making the request
    try {
      var token = await getTokenLocally();
      _dio.options.headers['Authorization'] = "bearer $token";
      
      print("Fetching biomarkers from: ${Endpoints.biomarker}");
      await _dio.post(Endpoints.biomarker).then((value) {
        // Handle the response based on the status code
        if (value.statusCode == 200) {
          // If the response is successful (status code 200), emit success state with the data
          print("API Response: ${json.encode(value.data)}");
          
          // Check if the response has the expected structure
          if (value.data is Map) {
            var responseData = value.data as Map;
            print("Response keys: ${responseData.keys.toList()}");
            List<Map<String, dynamic>> biomarkers = getAllBiomarkers(value.data);
            // Transform the data to match the expected structure
            Map<String, dynamic> transformedData = {
              "data": biomarkers 
            };
            
            print("Transformed data: ${json.encode(transformedData)}");
            print("Number of biomarkers: ${(transformedData['data'] as List).length}");
             print("Transformed data: ${transformedData['data']}");
            emit(SuccessBiomarkerState(biomarkerData: transformedData));
          } else {
            print("Unexpected response type: ${value.data.runtimeType}");
            emit(ErrorBiomarkerState());
          }
        } else {
          // If the response status code is not 200, emit an error state
          print("Error status code: ${value.statusCode}");
          emit(ErrorBiomarkerState());
        }
      });
    } catch (e) {
      // If an exception occurs, emit an error state
      print("Error fetching biomarkers: $e");
      print("Error type: ${e.runtimeType}");
      emit(ErrorBiomarkerState());
    }
  }
}
