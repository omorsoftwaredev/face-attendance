import 'package:flutter/material.dart';

import '../models/department_model.dart';
import '../services/department_service.dart';

class DepartmentProvider extends ChangeNotifier {
  DepartmentProvider({
    DepartmentService? service,
  }) : _service = service ?? DepartmentService();

  final DepartmentService _service;

  List<DepartmentModel> _departments = [];
  List<DepartmentModel> _filteredDepartments = [];

  bool _isLoading = false;
  String? _error;

  List<DepartmentModel> get departments => _departments;

  List<DepartmentModel> get filteredDepartments =>
      _filteredDepartments;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadDepartments({
    required String companyId,
  }) async {
    _setLoading(true);

    try {
      _error = null;

      _departments = await _service.getDepartments(
        companyId: companyId,
      );

      _filteredDepartments =
      List<DepartmentModel>.from(_departments);
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<bool> createDepartment({
    required DepartmentModel department,
  }) async {
    try {
      _error = null;

      final newDepartment =
      await _service.createDepartment(
        department: department,
      );

      _departments.add(newDepartment);

      _sort();

      _filteredDepartments =
      List<DepartmentModel>.from(_departments);

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> updateDepartment({
    required DepartmentModel department,
  }) async {
    try {
      _error = null;

      final updatedDepartment =
      await _service.updateDepartment(
        department: department,
      );

      final index = _departments.indexWhere(
            (e) => e.id == updatedDepartment.id,
      );

      if (index != -1) {
        _departments[index] = updatedDepartment;
      }

      _sort();

      _filteredDepartments =
      List<DepartmentModel>.from(_departments);

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> deleteDepartment(
      String id,
      ) async {
    try {
      _error = null;

      await _service.deleteDepartment(id);

      _departments.removeWhere(
            (e) => e.id == id,
      );

      _filteredDepartments.removeWhere(
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
      _filteredDepartments =
      List<DepartmentModel>.from(_departments);
    } else {
      final query = keyword.toLowerCase();

      _filteredDepartments = _departments.where((department) {
        return department.departmentName
            .toLowerCase()
            .contains(query) ||
            (department.description ?? '')
                .toLowerCase()
                .contains(query);
      }).toList();
    }

    notifyListeners();
  }

  Future<void> refresh({
    required String companyId,
  }) async {
    await loadDepartments(
      companyId: companyId,
    );
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _sort() {
    _departments.sort(
          (a, b) => a.departmentName
          .toLowerCase()
          .compareTo(
        b.departmentName.toLowerCase(),
      ),
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}