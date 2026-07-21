import 'package:flutter/material.dart';

import '../models/shift_model.dart';
import '../services/shift_service.dart';

class ShiftProvider extends ChangeNotifier {
  ShiftProvider({
    ShiftService? service,
  }) : _service = service ?? ShiftService();

  final ShiftService _service;

  List<ShiftModel> _shifts = [];
  List<ShiftModel> _filteredShifts = [];

  bool _isLoading = false;
  String? _error;

  List<ShiftModel> get shifts => _shifts;

  List<ShiftModel> get filteredShifts => _filteredShifts;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadShifts({
    required String companyId,
  }) async {
    _setLoading(true);

    try {
      _error = null;

      _shifts = await _service.getShifts(
        companyId: companyId,
      );

      _filteredShifts = List<ShiftModel>.from(
        _shifts,
      );
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<void> loadActiveShifts({
    required String companyId,
  }) async {
    _setLoading(true);

    try {
      _error = null;

      _shifts = await _service.getActiveShifts(
        companyId: companyId,
      );

      _filteredShifts = List<ShiftModel>.from(
        _shifts,
      );
    } catch (e) {
      _error = e.toString();
    }

    _setLoading(false);
  }

  Future<bool> createShift({
    required ShiftModel shift,
  }) async {
    try {
      _error = null;

      final created =
      await _service.createShift(
        shift: shift,
      );

      _shifts.add(created);

      _sort();

      _filteredShifts = List<ShiftModel>.from(
        _shifts,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> updateShift({
    required ShiftModel shift,
  }) async {
    try {
      _error = null;

      final updated =
      await _service.updateShift(
        shift: shift,
      );

      final index = _shifts.indexWhere(
            (e) => e.id == updated.id,
      );

      if (index != -1) {
        _shifts[index] = updated;
      }

      _sort();

      _filteredShifts = List<ShiftModel>.from(
        _shifts,
      );

      notifyListeners();

      return true;
    } catch (e) {
      _error = e.toString();

      notifyListeners();

      return false;
    }
  }

  Future<bool> deleteShift(
      String id,
      ) async {
    try {
      _error = null;

      await _service.deleteShift(id);

      _shifts.removeWhere(
            (e) => e.id == id,
      );

      _filteredShifts.removeWhere(
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
      _filteredShifts = List<ShiftModel>.from(
        _shifts,
      );
    } else {
      final query = keyword.toLowerCase();

      _filteredShifts = _shifts.where((shift) {
        return shift.shiftName
            .toLowerCase()
            .contains(query);
      }).toList();
    }

    notifyListeners();
  }

  Future<void> refresh({
    required String companyId,
  }) async {
    await loadShifts(
      companyId: companyId,
    );
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void _sort() {
    _shifts.sort(
          (a, b) => a.shiftName
          .toLowerCase()
          .compareTo(
        b.shiftName.toLowerCase(),
      ),
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}