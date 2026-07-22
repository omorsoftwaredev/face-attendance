import 'package:flutter/foundation.dart';

import 'package:worktrack_pro/core/models/employee_model.dart';
import 'package:worktrack_pro/core/services/employee_service.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeeProvider();

  final EmployeeService _service = EmployeeService();

  List<EmployeeModel> _employees = [];
  List<EmployeeModel> _filteredEmployees = [];

  bool _isLoading = false;

  String? _error;

  List<EmployeeModel> get employees => _employees;

  List<EmployeeModel> get filteredEmployees => _filteredEmployees;

  bool get isLoading => _isLoading;

  String? get error => _error;

  /// Load Employees
  Future<void> loadEmployees({
    required String companyId,
  }) async {
    try {
      _setLoading(true);
      _error = null;

      _employees = await _service.getEmployees(
        companyId: companyId,
      );

      _filteredEmployees = List.from(_employees);
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// Search Employee
  void search(String keyword) {
    final value = keyword.trim().toLowerCase();

    if (value.isEmpty) {
      _filteredEmployees = List.from(_employees);
    } else {
      _filteredEmployees = _employees.where((employee) {
        return employee.fullName
            .toLowerCase()
            .contains(value) ||
            employee.employeeCode
                .toLowerCase()
                .contains(value) ||
            (employee.email ?? '')
                .toLowerCase()
                .contains(value) ||
            (employee.phone ?? '')
                .toLowerCase()
                .contains(value);
      }).toList();
    }

    notifyListeners();
  }

  /// Create Employee
  Future<bool> createEmployee({
    required String companyId,
    String? departmentId,
    required String employeeCode,
    required String fullName,
    String? email,
    String? phone,
    String? designationName,
    String? profilePhoto,
  }) async {
    try {
      _setLoading(true);
      _error = null;

      await _service.createEmployee(
        companyId: companyId,
        departmentId: departmentId,
        employeeCode: employeeCode,
        fullName: fullName,
        email: email,
        phone: phone,
        designationName: designationName,
        profilePhoto: profilePhoto,
      );

      await loadEmployees(
        companyId: companyId,
      );

      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update Employee
  Future<bool> updateEmployee({
    required String id,
    required String companyId,
    String? departmentId,
    required String employeeCode,
    required String fullName,
    String? email,
    String? phone,
    String? designationName,
    String? profilePhoto,
    required bool isActive,
  }) async {
    try {
      _setLoading(true);
      _error = null;

      await _service.updateEmployee(
        id: id,
        companyId: companyId,
        departmentId: departmentId,
        employeeCode: employeeCode,
        fullName: fullName,
        email: email,
        phone: phone,
        designationName: designationName,
        profilePhoto: profilePhoto,
        isActive: isActive,
      );

      await loadEmployees(
        companyId: companyId,
      );

      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Delete Employee
  Future<bool> deleteEmployee(String id) async {
    try {
      _setLoading(true);
      _error = null;

      await _service.deleteEmployee(id);

      _employees.removeWhere(
            (employee) => employee.id == id,
      );

      _filteredEmployees.removeWhere(
            (employee) => employee.id == id,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Active Employees
  void showActiveEmployees() {
    _filteredEmployees = _employees
        .where((employee) => employee.isActive)
        .toList();

    notifyListeners();
  }

  /// Inactive Employees
  void showInactiveEmployees() {
    _filteredEmployees = _employees
        .where((employee) => !employee.isActive)
        .toList();

    notifyListeners();
  }

  /// Clear Filter
  void clearFilter() {
    _filteredEmployees = List.from(_employees);
    notifyListeners();
  }

  /// Clear Error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}