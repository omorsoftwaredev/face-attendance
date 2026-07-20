class CompanyModel {
  final String id;
  final String userId;
  final String companyName;
  final String? companyEmail;
  final String? phone;
  final String? address;
  final String? logoUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CompanyModel({
    required this.id,
    required this.userId,
    required this.companyName,
    this.companyEmail,
    this.phone,
    this.address,
    this.logoUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      id: json['id'],
      userId: json['user_id'],
      companyName: json['company_name'],
      companyEmail: json['company_email'],
      phone: json['phone'],
      address: json['address'],
      logoUrl: json['logo_url'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'company_name': companyName,
      'company_email': companyEmail,
      'phone': phone,
      'address': address,
      'logo_url': logoUrl,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  CompanyModel copyWith({
    String? id,
    String? userId,
    String? companyName,
    String? companyEmail,
    String? phone,
    String? address,
    String? logoUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CompanyModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      companyEmail: companyEmail ?? this.companyEmail,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      logoUrl: logoUrl ?? this.logoUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}