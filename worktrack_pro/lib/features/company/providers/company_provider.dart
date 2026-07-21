import 'package:flutter/foundation.dart';

import 'package:worktrack_pro/core/models/company_model.dart';
import 'package:worktrack_pro/core/services/company_service.dart';

class CompanyProvider extends ChangeNotifier {
  CompanyProvider();

  final CompanyService _service = CompanyService();

  List<CompanyModel> _companies = [];

  List<CompanyModel> _filteredCompanies = [];

  CompanyModel? _selectedCompany;

  bool _isLoading = false;

  String? _error;

  List<CompanyModel> get companies => _companies;

  List<CompanyModel> get filteredCompanies => _filteredCompanies;

  CompanyModel? get selectedCompany => _selectedCompany;

  bool get isLoading => _isLoading;

  String? get error => _error;

  /// Load All Companies
  Future<void> loadCompanies() async {
    try {
      _setLoading(true);
      _error = null;

      _companies = await _service.getCompanies();

      _filteredCompanies = List.from(_companies);

      if (_selectedCompany == null &&
          _companies.isNotEmpty) {
        _selectedCompany = _companies.first;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  /// Select Company
  void selectCompany(
      CompanyModel company,
      ) {
    _selectedCompany = company;
    notifyListeners();
  }

  /// Search Company
  void search(String keyword) {
    if (keyword.trim().isEmpty) {
      _filteredCompanies = List.from(_companies);
    } else {
      final query = keyword.toLowerCase();

      _filteredCompanies = _companies.where((company) {
        return company.companyName
            .toLowerCase()
            .contains(query) ||
            (company.companyEmail ?? '')
                .toLowerCase()
                .contains(query) ||
            (company.phone ?? '')
                .toLowerCase()
                .contains(query);
      }).toList();
    }

    notifyListeners();
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

      if (_selectedCompany?.id == id) {
        _selectedCompany = _companies.firstWhere(
              (company) => company.id == id,
          orElse: () => _companies.first,
        );
      }

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
  Future<bool> deleteCompany(
      String id,
      ) async {
    try {
      _setLoading(true);
      _error = null;

      await _service.deleteCompany(id);

      _companies.removeWhere(
            (company) => company.id == id,
      );

      _filteredCompanies.removeWhere(
            (company) => company.id == id,
      );

      if (_selectedCompany?.id == id) {
        _selectedCompany = _companies.isNotEmpty
            ? _companies.first
            : null;
      }

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

  void _setLoading(
      bool value,
      ) {
    _isLoading = value;
    notifyListeners();
  }
}