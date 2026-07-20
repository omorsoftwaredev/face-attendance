import 'package:flutter/foundation.dart';

import 'package:worktrack_pro/core/models/company_model.dart';
import 'package:worktrack_pro/core/services/company_service.dart';

class CompanyProvider extends ChangeNotifier {
  CompanyProvider();

  final CompanyService _service = CompanyService();

  List<CompanyModel> _companies = [];

  bool _isLoading = false;

  String? _error;

  List<CompanyModel> get companies => _companies;

  bool get isLoading => _isLoading;

  String? get error => _error;

  /// Load All Companies
  Future<void> loadCompanies() async {
    try {
      _setLoading(true);
      _error = null;

      _companies = await _service.getCompanies();
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// Create Company
  Future<bool> createCompany({
    required String companyName,
    String? companyEmail,
    String? phone,
    String? address,
  }) async {
    try {
      _setLoading(true);
      _error = null;

      await _service.createCompany(
        companyName: companyName,
        companyEmail: companyEmail,
        phone: phone,
        address: address,
      );

      await loadCompanies();

      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Update Company
  Future<bool> updateCompany({
    required String id,
    required String companyName,
    String? companyEmail,
    String? phone,
    String? address,
    String? logoUrl,
    bool? isActive,
  }) async {
    try {
      _setLoading(true);
      _error = null;

      await _service.updateCompany(
        id: id,
        companyName: companyName,
        companyEmail: companyEmail,
        phone: phone,
        address: address,
        logoUrl: logoUrl,
        isActive: isActive,
      );

      await loadCompanies();

      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Delete Company
  Future<bool> deleteCompany(String id) async {
    try {
      _setLoading(true);
      _error = null;

      await _service.deleteCompany(id);

      _companies.removeWhere((company) => company.id == id);

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