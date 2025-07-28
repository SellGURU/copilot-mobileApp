import 'package:dio/dio.dart';
import '../constants/endPoints.dart';
import '../utility/token/getTokenLocaly.dart';

/// Utility to test branding endpoint
class EndpointTest {
  
  /// Test branding endpoint with detailed logging
  static Future<void> testBrandingEndpoint() async {
    print('=== Testing Branding Endpoint ===');
    
    try {
      // Get token
      final token = await getTokenLocally();
      print('Token available: ${token != null ? "Yes" : "No"}');
      if (token != null) {
        print('Token length: ${token.length}');
      }
      
      // Create Dio instance
      final dio = Dio();
      dio.options.headers['Authorization'] = "Bearer $token";
      dio.options.headers['Content-Type'] = 'application/json';
      
      print('Endpoint URL: ${Endpoints.brandingInfo}');
      print('Request headers: ${dio.options.headers}');
      
      // Make request
      final response = await dio.post(
        Endpoints.brandingInfo,
        data: {},
        options: Options(
          validateStatus: (status) => true, // Accept all status codes
        ),
      );
      
      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        print('✅ Success: Endpoint is working');
      } else {
        print('❌ Error: Status code ${response.statusCode}');
      }
      
    } catch (e) {
      print('❌ Exception: $e');
      if (e is DioException) {
        print('DioException type: ${e.type}');
        print('DioException message: ${e.message}');
        print('DioException response: ${e.response?.data}');
      }
    }
  }
  
  /// Test with different HTTP methods
  static Future<void> testDifferentMethods() async {
    print('=== Testing Different HTTP Methods ===');
    
    final token = await getTokenLocally();
    final dio = Dio();
    dio.options.headers['Authorization'] = "Bearer $token";
    
    final methods = ['GET', 'POST', 'PUT'];
    
    for (final method in methods) {
      try {
        print('\nTesting $method method...');
        
        Response response;
        switch (method) {
          case 'GET':
            response = await dio.get(Endpoints.brandingInfo);
            break;
          case 'POST':
            response = await dio.post(Endpoints.brandingInfo, data: {});
            break;
          case 'PUT':
            response = await dio.put(Endpoints.brandingInfo, data: {});
            break;
          default:
            continue;
        }
        
        print('$method Status: ${response.statusCode}');
        print('$method Data: ${response.data}');
        
      } catch (e) {
        print('$method Error: $e');
      }
    }
  }
  
  /// Test without authentication
  static Future<void> testWithoutAuth() async {
    print('=== Testing Without Authentication ===');
    
    try {
      final dio = Dio();
      final response = await dio.post(
        Endpoints.brandingInfo,
        data: {},
      );
      
      print('Status without auth: ${response.statusCode}');
      print('Data without auth: ${response.data}');
      
    } catch (e) {
      print('Error without auth: $e');
    }
  }
} 