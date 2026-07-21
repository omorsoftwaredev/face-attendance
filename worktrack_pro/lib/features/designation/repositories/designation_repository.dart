import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/designation_model.dart';

class DesignationRepository {
  DesignationRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'designations';

  Future<List<DesignationModel>> getDesignations({
    required String companyId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('company_id', companyId)
        .order('designation_name');

    return (response as List)
        .map(
          (e) => DesignationModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<DesignationModel?> getDesignationById(
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

    return DesignationModel.fromJson(response);
  }

  Future<DesignationModel> createDesignation({
    required DesignationModel designation,
  }) async {
    final response = await _client
        .from(_table)
        .insert(designation.toJson())
        .select()
        .single();

    return DesignationModel.fromJson(response);
  }

  Future<DesignationModel> updateDesignation({
    required DesignationModel designation,
  }) async {
    final response = await _client
        .from(_table)
        .update(designation.toJson())
        .eq('id', designation.id)
        .select()
        .single();

    return DesignationModel.fromJson(response);
  }

  Future<void> deleteDesignation(
      String id,
      ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  Future<bool> designationNameExists({
    required String companyId,
    required String designationName,
    String? excludeId,
  }) async {
    var query = _client
        .from(_table)
        .select('id')
        .eq('company_id', companyId)
        .ilike(
      'designation_name',
      designationName,
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

  Future<List<DesignationModel>>
  getByDepartment({
    required String departmentId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('department_id', departmentId)
        .order('designation_name');

    return (response as List)
        .map(
          (e) => DesignationModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }
}