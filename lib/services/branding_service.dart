import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/branding_data.dart';
import '../utility/branding_helper.dart';
import 'package:dio/dio.dart';
import '../../../utility/token/getTokenLocaly.dart';
import '../../../constants/endPoints.dart';

// Global branding service singleton
class BrandingService {
  static BrandingService? _instance;
  static BrandingService get instance {
    _instance ??= BrandingService._internal();
    return _instance!;
  }

  BrandingService._internal();

  BrandingData? _cachedData;
  bool _isLoading = false;

  // Getter for cached data
  BrandingData? get cachedData => _cachedData;
  bool get isLoading => _isLoading;

  // Load branding data and cache it globally
  Future<BrandingData> loadBrandingData() async {
    // Return cached data if available
    if (_cachedData != null) {
      return _cachedData!;
    }

    // Check local cache first
    final cached = await getCachedBrandingData();
    if (cached != null) {
      _cachedData = cached;
      return cached;
    }

    // Load from API if not cached
    _isLoading = true;
    Dio _dio = Dio();
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "Bearer $token";
    
    try {
      final response = await _dio.post(
        Endpoints.brandingInfo,
        data: {},
      );

      if (response.statusCode == 200) {
        final data = BrandingData.fromJson(jsonDecode(response.data));
        await cacheBrandingData(data);
        _cachedData = data;
        _isLoading = false;
        return data;
      } else {
        _isLoading = false;
        throw Exception('Failed to load branding data');
      }
    } catch (e) {
      _isLoading = false;
      throw Exception('Failed to load branding data');
    }
  }

  // Clear cached data
  void clearCache() {
    _cachedData = null;
  }

  // Refresh data from API
  Future<BrandingData> refreshBrandingData() async {
    _cachedData = null;
    return await loadBrandingData();
  }
}

// Legacy function for backward compatibility
Future<BrandingData> loadBrandingData() async {
  return await BrandingService.instance.loadBrandingData();
}
