import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/employee_model.dart';

class EmployeeRepository {
  EmployeeRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'company_employees';

  /// Get All Employees
  Future<List<EmployeeModel>> getEmployees() async {
    final response = await _client
        .from(_table)
        .select()
        .order('created_at', ascending: false);

    return (response as List)
        .map(
          (json) => EmployeeModel.fromJson(
        json as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  /// Get Employee By ID
  Future<EmployeeModel?> getEmployeeById(
      String id,
      ) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return EmployeeModel.fromJson(response);
  }

  /// Create Employee
  Future<void> createEmployee({
    required String companyId,
    String? departmentId,
    required String employeeCode,
    required String fullName,
    String? email,
    String? phone,
    String? designationName,
    String? profilePhoto,
  }) async {
    await _client.from(_table).insert({
      'company_id': companyId,
      'department_id': departmentId,
      'employee_code': employeeCode,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'designation_name': designationName,
      'profile_photo': profilePhoto,
      'is_active': true,
    });
  }

  /// Update Employee
  Future<void> updateEmployee({
    required String id,
    required String companyId,
    String? departmentId,
    required String employeeCode,
    required String fullName,
    String? email,
    String? phone,
    String? designationName,
    String? profilePhoto,
    required bool isActive,
  }) async {
    await _client
        .from(_table)
        .update({
      'company_id': companyId,
      'department_id': departmentId,
      'employee_code': employeeCode,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'designation_name': designationName,
      'profile_photo': profilePhoto,
      'is_active': isActive,
      'updated_at': DateTime.now().toIso8601String(),
    })
        .eq('id', id);
  }

  /// Delete Employee
  Future<void> deleteEmployee(
      String id,
      ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }
}