class DesignationModel {
  final String id;
  final String companyId;
  final String? departmentId;
  final String designationName;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DesignationModel({
    required this.id,
    required this.companyId,
    this.departmentId,
    required this.designationName,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DesignationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DesignationModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      departmentId: json['department_id'] as String?,
      designationName:
      json['designation_name'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ),
      updatedAt: DateTime.parse(
        json['updated_at'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'department_id': departmentId,
      'designation_name': designationName,
      'description': description,
      'is_active': isActive,
      'created_at':
      createdAt.toIso8601String(),
      'updated_at':
      updatedAt.toIso8601String(),
    };
  }

  DesignationModel copyWith({
    String? id,
    String? companyId,
    String? departmentId,
    String? designationName,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DesignationModel(
      id: id ?? this.id,
      companyId:
      companyId ?? this.companyId,
      departmentId:
      departmentId ?? this.departmentId,
      designationName:
      designationName ??
          this.designationName,
      description:
      description ?? this.description,
      isActive:
      isActive ?? this.isActive,
      createdAt:
      createdAt ?? this.createdAt,
      updatedAt:
      updatedAt ?? this.updatedAt,
    );
  }
}