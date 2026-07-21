import 'package:flutter/foundation.dart';

import '../../../core/models/attendance_model.dart';
import '../services/attendance_statistics_service.dart';

class AttendanceDashboardProvider extends ChangeNotifier {
  AttendanceDashboardProvider({
    AttendanceStatisticsService? statisticsService,
  }) : _statisticsService =
      statisticsService ??
          const AttendanceStatisticsService();

  final AttendanceStatisticsService _statisticsService;

  int totalEmployees = 0;
  int presentEmployees = 0;
  int absentEmployees = 0;
  int lateEmployees = 0;
  int totalWorkedMinutes = 0;
  int totalOvertimeMinutes = 0;
  double attendanceRate = 0;

  void calculate({
    required int employeeCount,
    required List<AttendanceModel> attendances,
  }) {
    totalEmployees = _statisticsService.totalEmployees(
      employeeCount: employeeCount,
    );

    presentEmployees = _statisticsService.presentCount(
      attendances: attendances,
    );

    absentEmployees = _statisticsService.absentCount(
      totalEmployees: totalEmployees,
      presentEmployees: presentEmployees,
    );

    lateEmployees = _statisticsService.lateCount(
      attendances: attendances,
    );

    attendanceRate =
        _statisticsService.attendanceRate(
          totalEmployees: totalEmployees,
          presentEmployees: presentEmployees,
        );

    totalWorkedMinutes =
        _statisticsService.totalWorkedMinutes(
          attendances: attendances,
        );

    totalOvertimeMinutes =
        _statisticsService.totalOvertimeMinutes(
          attendances: attendances,
        );

    notifyListeners();
  }
}