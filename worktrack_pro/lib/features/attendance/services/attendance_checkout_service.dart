import '../../../core/models/attendance_model.dart';
import '../repositories/attendance_repository.dart';
import 'attendance_engine.dart';

class AttendanceCheckoutService {
  AttendanceCheckoutService({
    AttendanceRepository? repository,
  }) : _repository = repository ?? AttendanceRepository();

  final AttendanceRepository _repository;

  Future<AttendanceModel> checkOut({
    required String attendanceId,
    required DateTime shiftEnd,
  }) async {
    final attendance =
    await _repository.getAttendanceById(
      attendanceId,
    );

    if (attendance == null) {
      throw Exception(
        'Attendance not found.',
      );
    }

    if (attendance.checkInTime == null) {
      throw Exception(
        'Employee has not checked in.',
      );
    }

    if (attendance.checkOutTime != null) {
      throw Exception(
        'Already checked out.',
      );
    }

    final now = DateTime.now();

    final workedMinutes =
    AttendanceEngine.workedMinutes(
      checkIn: attendance.checkInTime!,
      checkOut: now,
    );

    final earlyLeaveMinutes =
    AttendanceEngine.earlyLeaveMinutes(
      shiftEnd: shiftEnd,
      checkOut: now,
    );

    final overtimeMinutes =
    AttendanceEngine.overtimeMinutes(
      shiftEnd: shiftEnd,
      checkOut: now,
    );

    final updatedAttendance =
    attendance.copyWith(
      checkOutTime: now,
      workedMinutes: workedMinutes,
      earlyLeaveMinutes:
      earlyLeaveMinutes,
      overtimeMinutes:
      overtimeMinutes,
      updatedAt: now,
    );

    return await _repository.updateAttendance(
      attendance: updatedAttendance,
    );
  }
}