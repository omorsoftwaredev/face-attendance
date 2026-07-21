import '../../../core/models/attendance_model.dart';

class AttendanceStatisticsService {
  const AttendanceStatisticsService();

  int totalEmployees({
    required int employeeCount,
  }) {
    return employeeCount;
  }

  int presentCount({
    required List<AttendanceModel> attendances,
  }) {
    return attendances
        .where(
          (attendance) =>
      attendance.attendanceStatus ==
          'Present',
    )
        .length;
  }

  int absentCount({
    required int totalEmployees,
    required int presentEmployees,
  }) {
    final absent =
        totalEmployees - presentEmployees;

    return absent < 0 ? 0 : absent;
  }

  int lateCount({
    required List<AttendanceModel> attendances,
  }) {
    return attendances
        .where(
          (attendance) =>
      attendance.lateMinutes > 0,
    )
        .length;
  }

  double attendanceRate({
    required int totalEmployees,
    required int presentEmployees,
  }) {
    if (totalEmployees == 0) {
      return 0;
    }

    return (presentEmployees /
        totalEmployees) *
        100;
  }

  int totalWorkedMinutes({
    required List<AttendanceModel> attendances,
  }) {
    return attendances.fold(
      0,
          (total, attendance) =>
      total + attendance.workedMinutes,
    );
  }

  int totalOvertimeMinutes({
    required List<AttendanceModel> attendances,
  }) {
    return attendances.fold(
      0,
          (total, attendance) =>
      total +
          attendance.overtimeMinutes,
    );
  }
}