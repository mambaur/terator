class KopSuratModel {
  final String? logoPath;

  /// Optional second logo (e.g. pemda + instansi), placed opposite the main
  /// logo or next to it depending on the design.
  final String? secondaryLogoPath;
  final String institutionName;
  final String subtitle;
  final String address;
  final String telephone;
  final String email;
  final String website;
  final String designId;

  const KopSuratModel({
    this.logoPath,
    this.secondaryLogoPath,
    this.institutionName = '',
    this.subtitle = '',
    this.address = '',
    this.telephone = '',
    this.email = '',
    this.website = '',
    this.designId = 'klasik',
  });

  /// Kop is usable once at least a logo or institution name is set.
  bool get isConfigured =>
      (logoPath != null && logoPath!.isNotEmpty) ||
      (secondaryLogoPath != null && secondaryLogoPath!.isNotEmpty) ||
      institutionName.trim().isNotEmpty;

  KopSuratModel copyWith({
    String? logoPath,
    bool clearLogo = false,
    String? secondaryLogoPath,
    bool clearSecondaryLogo = false,
    String? institutionName,
    String? subtitle,
    String? address,
    String? telephone,
    String? email,
    String? website,
    String? designId,
  }) {
    return KopSuratModel(
      logoPath: clearLogo ? null : (logoPath ?? this.logoPath),
      secondaryLogoPath: clearSecondaryLogo
          ? null
          : (secondaryLogoPath ?? this.secondaryLogoPath),
      institutionName: institutionName ?? this.institutionName,
      subtitle: subtitle ?? this.subtitle,
      address: address ?? this.address,
      telephone: telephone ?? this.telephone,
      email: email ?? this.email,
      website: website ?? this.website,
      designId: designId ?? this.designId,
    );
  }

  KopSuratModel.fromJson(Map<String, dynamic> json)
      : logoPath = json['logo_path'],
        secondaryLogoPath = json['secondary_logo_path'],
        institutionName = json['institution_name'] ?? '',
        subtitle = json['subtitle'] ?? '',
        address = json['address'] ?? '',
        telephone = json['telephone'] ?? '',
        email = json['email'] ?? '',
        website = json['website'] ?? '',
        designId = json['design_id'] ?? 'klasik';

  Map<String, dynamic> toJson() => {
        'logo_path': logoPath,
        'secondary_logo_path': secondaryLogoPath,
        'institution_name': institutionName,
        'subtitle': subtitle,
        'address': address,
        'telephone': telephone,
        'email': email,
        'website': website,
        'design_id': designId,
      };
}
