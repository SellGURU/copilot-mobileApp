import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/branding_data.dart';
import '../utility/branding_helper.dart';
import 'package:dio/dio.dart';
import '../utility/token/getTokenLocaly.dart';
import '../constants/endPoints.dart';

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
    print('BrandingService: Attempting to load from API first');
    
    _isLoading = true;
    
    // First, try to get cached data as fallback
    final cached = await getCachedBrandingData();
    if (cached != null) {
      print('BrandingService: Found cached data, using as fallback');
      _cachedData = cached;
    }

    // Try to load from API
    Dio _dio = Dio();
    
    try {
      var token = await getTokenLocally();
      
      _dio.options.headers['Authorization'] = "Bearer $token"; 
      
      final response = await _dio.post(
        Endpoints.brandingInfo,
        data: {},
      );

      if (response.statusCode == 200) {
        final data = BrandingData.fromJson(response.data);
        await cacheBrandingData(data);
        _cachedData = data;
        _isLoading = false;
        print('BrandingService: Successfully loaded from API and updated cache');
        return data;
      } else {
        _isLoading = false;
        print('BrandingService: API returned status ${response.statusCode}, using cached data');
        if (_cachedData != null) {
          return _cachedData!;
        }
        return _getFallbackBrandingData();
      }
    } catch (e) {
      _isLoading = false;
      print('BrandingService: API call failed: $e, using cached data');
      
      // Return cached data if available, otherwise fallback
      if (_cachedData != null) {
        return _cachedData!;
      }
      return _getFallbackBrandingData();
    }
  }

  // Fallback branding data when API fails
  BrandingData _getFallbackBrandingData() {
    return BrandingData(
      name: 'Holisticare',
      headline: 'Your Health, Our Priority',
      primaryColorHex: '#006073', // mainSecandaryColor
      secondaryColorHex: '#dce7ea',
      tone: 'Professional and Caring',
      focusArea: 'holistic_health',
      logo: '',
      lastUpdate: DateTime.now().toIso8601String(),
    );
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
