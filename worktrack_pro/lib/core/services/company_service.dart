import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:worktrack_pro/core/models/company_model.dart';
import 'package:worktrack_pro/core/repositories/company_repository.dart';

class CompanyService {
  CompanyService();

  final CompanyRepository _repository = CompanyRepository();

  /// Create Company
  Future<void> createCompany({
    required String companyName,
    String? companyEmail,
    String? phone,
    String? address,
    String? logoUrl,
  }) async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in.');
    }

    final company = CompanyModel(
      id: '',
      userId: user.id,
      companyName: companyName.trim(),
      companyEmail: companyEmail?.trim(),
      phone: phone?.trim(),
      address: address?.trim(),
      logoUrl: logoUrl,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _repository.createCompany(company);
  }

  /// Get All Companies
  Future<List<CompanyModel>> getCompanies() async {
    return await _repository.getCompanies();
  }

  /// Get Company By ID
  Future<CompanyModel?> getCompanyById(String companyId) async {
    return await _repository.getCompanyById(companyId);
  }

  /// Update Company
  Future<void> updateCompany({
    required String id,
    required String companyName,
    String? companyEmail,
    String? phone,
    String? address,
    String? logoUrl,
    bool? isActive,
  }) async {
    final data = <String, dynamic>{
      'company_name': companyName.trim(),
      'company_email': companyEmail?.trim(),
      'phone': phone?.trim(),
      'address': address?.trim(),
      'logo_url': logoUrl,
      'updated_at': DateTime.now().toIso8601String(),
    };

    if (isActive != null) {
      data['is_active'] = isActive;
    }

    await _repository.updateCompany(
      id: id,
      data: data,
    );
  }

  /// Delete Company
  Future<void> deleteCompany(String id) async {
    await _repository.deleteCompany(id);
  }
}