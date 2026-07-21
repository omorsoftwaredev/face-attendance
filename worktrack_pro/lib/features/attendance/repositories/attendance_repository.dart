import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/models/attendance_model.dart';

class AttendanceRepository {
  AttendanceRepository({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  static const String _table = 'attendances';

  Future<List<AttendanceModel>> getAttendances({
    required String companyId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('company_id', companyId)
        .order(
      'attendance_date',
      ascending: false,
    );

    return (response as List)
        .map(
          (e) => AttendanceModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<List<AttendanceModel>>
  getEmployeeAttendances({
    required String employeeId,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('employee_id', employeeId)
        .order(
      'attendance_date',
      ascending: false,
    );

    return (response as List)
        .map(
          (e) => AttendanceModel.fromJson(
        e as Map<String, dynamic>,
      ),
    )
        .toList();
  }

  Future<AttendanceModel?> getAttendanceById(
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

    return AttendanceModel.fromJson(response);
  }

  Future<AttendanceModel?> getAttendanceByDate({
    required String employeeId,
    required DateTime attendanceDate,
  }) async {
    final response = await _client
        .from(_table)
        .select()
        .eq('employee_id', employeeId)
        .eq(
      'attendance_date',
      attendanceDate
          .toIso8601String()
          .split('T')
          .first,
    )
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return AttendanceModel.fromJson(response);
  }

  Future<AttendanceModel> createAttendance({
    required AttendanceModel attendance,
  }) async {
    final response = await _client
        .from(_table)
        .insert(attendance.toJson())
        .select()
        .single();

    return AttendanceModel.fromJson(response);
  }

  Future<AttendanceModel> updateAttendance({
    required AttendanceModel attendance,
  }) async {
    final response = await _client
        .from(_table)
        .update(attendance.toJson())
        .eq('id', attendance.id)
        .select()
        .single();

    return AttendanceModel.fromJson(response);
  }

  Future<void> deleteAttendance(
      String id,
      ) async {
    await _client
        .from(_table)
        .delete()
        .eq('id', id);
  }
}