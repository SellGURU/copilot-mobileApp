class BrandingData {
  final String title;
  final String slogan;
  final String primaryColorHex;

  BrandingData({
    required this.title,
    required this.slogan,
    required this.primaryColorHex,
  });

  factory BrandingData.fromJson(Map<String, dynamic> json) {
    return BrandingData(
      title: json['title'],
      slogan: json['slogan'],
      primaryColorHex: json['primaryColorHex'],
    );
  }
}
