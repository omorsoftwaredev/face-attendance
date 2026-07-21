import '../../../core/models/attendance_model.dart';
import '../repositories/attendance_repository.dart';

class AttendanceService {
  AttendanceService({
    AttendanceRepository? repository,
  }) : _repository = repository ?? AttendanceRepository();

  final AttendanceRepository _repository;

  Future<List<AttendanceModel>> getAttendances({
    required String companyId,
  }) async {
    return await _repository.getAttendances(
      companyId: companyId,
    );
  }

  Future<List<AttendanceModel>> getEmployeeAttendances({
    required String employeeId,
  }) async {
    return await _repository.getEmployeeAttendances(
      employeeId: employeeId,
    );
  }

  Future<AttendanceModel?> getAttendanceById(
      String id,
      ) async {
    return await _repository.getAttendanceById(id);
  }

  Future<AttendanceModel?> getAttendanceByDate({
    required String employeeId,
    required DateTime attendanceDate,
  }) async {
    return await _repository.getAttendanceByDate(
      employeeId: employeeId,
      attendanceDate: attendanceDate,
    );
  }

  Future<AttendanceModel> createAttendance({
    required AttendanceModel attendance,
  }) async {
    final existing =
    await _repository.getAttendanceByDate(
      employeeId: attendance.employeeId,
      attendanceDate: attendance.attendanceDate,
    );

    if (existing != null) {
      throw Exception(
        'Attendance already exists for this date.',
      );
    }

    return await _repository.createAttendance(
      attendance: attendance,
    );
  }

  Future<AttendanceModel> updateAttendance({
    required AttendanceModel attendance,
  }) async {
    return await _repository.updateAttendance(
      attendance: attendance,
    );
  }

  Future<void> deleteAttendance(
      String id,
      ) async {
    await _repository.deleteAttendance(id);
  }
}