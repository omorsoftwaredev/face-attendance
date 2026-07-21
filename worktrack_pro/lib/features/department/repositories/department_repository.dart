import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/department_model.dart';

class DepartmentRepository {
  DepartmentRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'departments';

  Future<List<DepartmentModel>> getDepartments({
    required String companyId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('company_id', companyId)
        .order('department_name');

    return (response as List)
        .map(
          (e) => DepartmentModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

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

  Future<void> deleteDepartment(
      String id,
      ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

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
      query = query.neq('id', excludeId);
    }

    final response = await query;

    return (response as List).isNotEmpty;
  }
}