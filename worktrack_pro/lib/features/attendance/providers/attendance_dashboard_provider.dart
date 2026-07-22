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

  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Refresh Dashboard
  Future<void> refreshDashboard({
    required int employeeCount,
    required List<AttendanceModel> attendances,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      calculate(
        employeeCount: employeeCount,
        attendances: attendances,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Calculate Dashboard Statistics
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

    attendanceRate = _statisticsService.attendanceRate(
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

  /// Reset Dashboard
  void clear() {
    totalEmployees = 0;
    presentEmployees = 0;
    absentEmployees = 0;
    lateEmployees = 0;
    totalWorkedMinutes = 0;
    totalOvertimeMinutes = 0;
    attendanceRate = 0;
    _error = null;

    notifyListeners();
  }
}