import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/department_model.dart';

class DepartmentRepository {
  DepartmentRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'departments';

  /// Get All Departments
  Future<List<DepartmentModel>> getDepartments({
    required String companyId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('company_id', companyId)
        .order(
      'department_name',
      ascending: true,
    );

    return (response as List)
        .map(
          (json) => DepartmentModel.fromJson(
        json as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  /// Get Department By ID
  Future<DepartmentModel?> getDepartmentById(
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

    return DepartmentModel.fromJson(response);
  }

  /// Create Department
  Future<DepartmentModel> createDepartment({
    required DepartmentModel department,
  }) async {
    final response = await _client
        .from(_table)
        .insert(department.toJson())
        .select()
        .single();

    return DepartmentModel.fromJson(response);
  }

  /// Update Department
  Future<DepartmentModel> updateDepartment({
    required DepartmentModel department,
  }) async {
    final response = await _client
        .from(_table)
        .update(department.toJson())
        .eq('id', department.id)
        .select()
        .single();

    return DepartmentModel.fromJson(response);
  }

  /// Delete Department
  Future<void> deleteDepartment(
      String id,
      ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  /// Check Duplicate Department Name
  Future<bool> departmentNameExists({
    required String companyId,
    required String departmentName,
    String? excludeId,
  }) async {
    var query = _client
        .from(_table)
        .select('id')
        .eq('company_id', companyId)
        .ilike(
      'department_name',
      departmentName,
    );

    if (excludeId != null) {
      query = query.neq(
        'id',
        excludeId,
      );
    }

    final response = await query;

    return (response as List).isNotEmpty;
  }
}