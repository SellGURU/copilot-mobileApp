import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/endPoints.dart';
import '../../../utility/token/getTokenLocaly.dart';
import 'state.dart';




/// `ClientInformationMobileCubit` manages the client information fetching process.
class ClientInformationMobileCubit extends Cubit<ClientInformationMobileState> {
  ClientInformationMobileCubit() : super(ClientInformationMobileState()) {
    getPdf(); // Automatically fetches client information upon initialization.
  }

  final Dio _dio = Dio();

  /// Fetches the client information from the server and manages the state transitions.
  Future<void> getPdf() async {
    // Avoid redundant calls if the current state is already successful
    if (state is! SuccessClientInformation) {
      emit(LoadingClientInformationMobileState()); // Emit loading state before starting the request.

      var token = await getTokenLocally(); // Retrieve the token for authorization.
      _dio.options.headers['Authorization'] = "bearer $token";

      try {
        // Make the API request
        _dio.post(Endpoints.clientInformationMobile).then((res) async {
          if (res.data != null) {
            // Emit success state with the retrieved user information
            emit(SuccessClientInformation(userInfo: res.data));
            print("res.data info:${res.data}");

            // Save client name in local shared preferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('name', res.data["name"]);
          } else {
            // Handle null response data by emitting an error state
            emit(ErrorClientInformationMobileState());
          }
        });
      } catch (e) {
        // Handle errors during the API request
        print("error info $e");
        emit(ErrorClientInformationMobileState());
      }
    }
  }

  /// Refreshes the client information by re-fetching data.
  Future<void> refresh() async {
    print("Refreshing data...");
    emit(LoadingClientInformationMobileState());
    await getPdf(); // Call the same method to refresh data
  }
}
