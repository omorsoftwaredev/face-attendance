class EmployeeModel {
  final String id;
  final String companyId;
  final String? departmentId;
  final String employeeCode;
  final String fullName;
  final String? email;
  final String? phone;
  final String? designationName;
  final String? profilePhoto;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const EmployeeModel({
    required this.id,
    required this.companyId,
    this.departmentId,
    required this.employeeCode,
    required this.fullName,
    this.email,
    this.phone,
    this.designationName,
    this.profilePhoto,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String,
      companyId: json['company_id'] as String,
      departmentId: json['department_id'] as String?,
      employeeCode: json['employee_code'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      designationName: json['designation_name'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'department_id': departmentId,
      'employee_code': employeeCode,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'designation_name': designationName,
      'profile_photo': profilePhoto,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  EmployeeModel copyWith({
    String? id,
    String? companyId,
    String? departmentId,
    String? employeeCode,
    String? fullName,
    String? email,
    String? phone,
    String? designationName,
    String? profilePhoto,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      departmentId: departmentId ?? this.departmentId,
      employeeCode: employeeCode ?? this.employeeCode,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      designationName: designationName ?? this.designationName,
      profilePhoto: profilePhoto ?? this.profilePhoto,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}