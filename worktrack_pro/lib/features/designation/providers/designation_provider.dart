import 'package:flutter/material.dart';

import '../models/designation_model.dart';
import '../services/designation_service.dart';

class DesignationProvider extends ChangeNotifier {
  DesignationProvider({
    DesignationService? service,
  }) : _service = service ?? DesignationService();

  final DesignationService _service;

  List<DesignationModel> _designations = [];
  List<DesignationModel> _filteredDesignations = [];

  bool _isLoading = false;
  String? _error;

  List<DesignationModel> get designations =>
      _designations;

  List<DesignationModel> get filteredDesignations =>
      _filteredDesignations;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadDesignations({
    required String companyId,
  }) async {
    _setLoading(true);

    try {
      _error = null;

      _designations =
      await _service.getDesignations(
        companyId: companyId,
      );

      _filteredDesignations =
      List<DesignationModel>.from(
        _designations,
      );
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<void> loadByDepartment({
    required String departmentId,
  }) async {
    _setLoading(true);

    try {
      _error = null;

      _designations =
      await _service.getByDepartment(
        departmentId: departmentId,
      );

      _filteredDesignations =
      List<DesignationModel>.from(
        _designations,
      );
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<bool> createDesignation({
    required DesignationModel designation,
  }) async {
    try {
      _error = null;

      final created =
      await _service.createDesignation(
        designation: designation,
      );

      _designations.add(created);

      _sort();

      _filteredDesignations =
      List<DesignationModel>.from(
        _designations,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> updateDesignation({
    required DesignationModel designation,
  }) async {
    try {
      _error = null;

      final updated =
      await _service.updateDesignation(
        designation: designation,
      );

      final index =
      _designations.indexWhere(
            (e) => e.id == updated.id,
      );

      if (index != -1) {
        _designations[index] = updated;
      }

      _sort();

      _filteredDesignations =
      List<DesignationModel>.from(
        _designations,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> deleteDesignation(
      String id,
      ) async {
    try {
      _error = null;

      await _service.deleteDesignation(
        id,
      );

      _designations.removeWhere(
            (e) => e.id == id,
      );

      _filteredDesignations.removeWhere(
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
      _filteredDesignations =
      List<DesignationModel>.from(
        _designations,
      );
    } else {
      final query =
      keyword.toLowerCase();

      _filteredDesignations =
          _designations.where((item) {
            return item.designationName
                .toLowerCase()
                .contains(query) ||
                (item.description ?? '')
                    .toLowerCase()
                    .contains(query);
          }).toList();
    }

    notifyListeners();
  }

  Future<void> refresh({
    required String companyId,
  }) async {
    await loadDesignations(
      companyId: companyId,
    );
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _sort() {
    _designations.sort(
          (a, b) => a.designationName
          .toLowerCase()
          .compareTo(
        b.designationName
            .toLowerCase(),
      ),
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}