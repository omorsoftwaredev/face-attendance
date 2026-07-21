import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/shift_model.dart';

class ShiftRepository {
  ShiftRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'shifts';

  Future<List<ShiftModel>> getShifts({
    required String companyId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('company_id', companyId)
        .order('shift_name');

    return (response as List)
        .map(
          (e) => ShiftModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<ShiftModel?> getShiftById(
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

    return ShiftModel.fromJson(response);
  }

  Future<ShiftModel> createShift({
    required ShiftModel shift,
  }) async {
    final response = await _client
        .from(_table)
        .insert(shift.toJson())
        .select()
        .single();

    return ShiftModel.fromJson(response);
  }

  Future<ShiftModel> updateShift({
    required ShiftModel shift,
  }) async {
    final response = await _client
        .from(_table)
        .update(shift.toJson())
        .eq('id', shift.id)
        .select()
        .single();

    return ShiftModel.fromJson(response);
  }

  Future<void> deleteShift(
      String id,
      ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }

  Future<bool> shiftNameExists({
    required String companyId,
    required String shiftName,
    String? excludeId,
  }) async {
    var query = _client
        .from(_table)
        .select('id')
        .eq('company_id', companyId)
        .ilike(
      'shift_name',
      shiftName,
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

  Future<List<ShiftModel>> getActiveShifts({
    required String companyId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('company_id', companyId)
        .eq('is_active', true)
        .order('shift_name');

    return (response as List)
        .map(
          (e) => ShiftModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }
}