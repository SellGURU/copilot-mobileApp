import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/branding_data.dart';
import '../utility/branding_helper.dart';

Future<BrandingData> loadBrandingData() async {
  final cached = await getCachedBrandingData();
  if (cached != null) return cached;

  final response = await http.get(Uri.parse('https://your-api.com/branding'));

  if (response.statusCode == 200) {
    final data = BrandingData.fromJson(jsonDecode(response.body));
    await cacheBrandingData(data);
    return data;
  } else {
    throw Exception('Failed to load branding data');
  }
}
