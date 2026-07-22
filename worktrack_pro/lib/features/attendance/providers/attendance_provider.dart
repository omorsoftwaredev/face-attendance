import 'package:flutter/material.dart';

import '../../../core/models/attendance_model.dart';
import '../services/attendance_service.dart';

class AttendanceProvider extends ChangeNotifier {
  AttendanceProvider({
    AttendanceService? service,
  }) : _service = service ?? AttendanceService();

  final AttendanceService _service;

  List<AttendanceModel> _attendances = [];
  List<AttendanceModel> _filteredAttendances = [];

  bool _isLoading = false;
  String? _error;

  List<AttendanceModel> get attendances => _attendances;

  List<AttendanceModel> get filteredAttendances =>
      _filteredAttendances;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadAttendances({
    required String companyId,
  }) async {
    _setLoading(true);

    try {
      _error = null;

      _attendances =
      await _service.getAttendances(
        companyId: companyId,
      );

      _filteredAttendances =
      List<AttendanceModel>.from(
        _attendances,
      );
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<void> loadEmployeeAttendances({
    required String employeeId,
  }) async {
    _setLoading(true);

    try {
      _error = null;

      _attendances =
      await _service.getEmployeeAttendances(
        employeeId: employeeId,
      );

      _filteredAttendances =
      List<AttendanceModel>.from(
        _attendances,
      );
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<bool> createAttendance({
    required AttendanceModel attendance,
  }) async {
    try {
      _error = null;

      final created =
      await _service.createAttendance(
        attendance: attendance,
      );

      _attendances.insert(0, created);

      _filteredAttendances =
      List<AttendanceModel>.from(
        _attendances,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> updateAttendance({
    required AttendanceModel attendance,
  }) async {
    try {
      _error = null;

      final updated =
      await _service.updateAttendance(
        attendance: attendance,
      );

      final index = _attendances.indexWhere(
            (e) => e.id == updated.id,
      );

      if (index != -1) {
        _attendances[index] = updated;
      }

      _filteredAttendances =
      List<AttendanceModel>.from(
        _attendances,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> deleteAttendance(
      String id,
      ) async {
    try {
      _error = null;

      await _service.deleteAttendance(id);

      _attendances.removeWhere(
            (e) => e.id == id,
      );

      _filteredAttendances.removeWhere(
            (e) => e.id == id,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  void search(String keyword) {
    if (keyword.trim().isEmpty) {
      _filteredAttendances =
      List<AttendanceModel>.from(
        _attendances,
      );
    } else {
      final query = keyword.toLowerCase();

      _filteredAttendances =
          _attendances.where((attendance) {
            return attendance.attendanceStatus
                .toLowerCase()
                .contains(query) ||
                attendance.employeeId
                    .toLowerCase()
                    .contains(query);
          }).toList();
    }

    notifyListeners();
  }
  AttendanceModel? getAttendanceById(String id) {
    try {
      return _attendances.firstWhere(
            (e) => e.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  // ================= AttendanceProvider =================

  Future<void> refresh({
    required String companyId,
  }) async {
    await loadAttendances(
      companyId: companyId,
    );
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}