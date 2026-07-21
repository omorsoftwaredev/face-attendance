class DepartmentModel {
  final String id;
  final String companyId;
  final String departmentName;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DepartmentModel({
    required this.id,
    required this.companyId,
    required this.departmentName,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DepartmentModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return DepartmentModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      departmentName:
      json['department_name'] as String,
      description:
      json['description'] as String?,
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
      'department_name': departmentName,
      'description': description,
      'is_active': isActive,
      'created_at':
      createdAt.toIso8601String(),
      'updated_at':
      updatedAt.toIso8601String(),
    };
  }

  DepartmentModel copyWith({
    String? id,
    String? companyId,
    String? departmentName,
    String? description,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DepartmentModel(
      id: id ?? this.id,
      companyId:
      companyId ?? this.companyId,
      departmentName:
      departmentName ??
          this.departmentName,
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