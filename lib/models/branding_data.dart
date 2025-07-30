class BrandingData {
  final String name;
  final String headline;
  final String primaryColorHex;
  final String secondaryColorHex;
  final String tone;
  final String focusArea;
  final String logo;
  final String lastUpdate;

  BrandingData({
    required this.name,
    required this.headline,
    required this.primaryColorHex,
    required this.secondaryColorHex,
    required this.tone,
    required this.focusArea,
    required this.logo,
    required this.lastUpdate,
  });

  factory BrandingData.fromJson(Map<String, dynamic> json) {
    final brandElements = json['brand_elements'] as Map<String, dynamic>;
    
    return BrandingData(
      name: brandElements['name'] ?? '',
      headline: brandElements['headline'] ?? '',
      primaryColorHex: brandElements['primary_color'] ?? '#000000',
      secondaryColorHex: brandElements['secondary_color'] ?? '#dce7ea',
      tone: brandElements['tone'] ?? '',
      focusArea: brandElements['focus_area'] ?? '',
      logo: brandElements['logo'] ?? '',
      lastUpdate: brandElements['last_update'] ?? '',
    );
  }

  // Legacy getters for backward compatibility
  String get title => name;
  String get slogan => headline;
}
