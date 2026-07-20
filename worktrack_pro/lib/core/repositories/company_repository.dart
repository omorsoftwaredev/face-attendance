import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:worktrack_pro/core/models/company_model.dart';

class CompanyRepository {
  CompanyRepository();

  final SupabaseClient _client = Supabase.instance.client;

  /// Create Company
  Future<void> createCompany(CompanyModel company) async {
    await _client.from('companies').insert({
      'user_id': company.userId,
      'company_name': company.companyName,
      'company_email': company.companyEmail,
      'phone': company.phone,
      'address': company.address,
      'logo_url': company.logoUrl,
      'is_active': company.isActive,
    });
  }

  /// Get All Companies of Current User
  Future<List<CompanyModel>> getCompanies() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('User not logged in.');
    }

    final response = await _client
        .from('companies')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => CompanyModel.fromJson(json))
        .toList();
  }

  /// Get Single Company By ID
  Future<CompanyModel?> getCompanyById(String companyId) async {
    final response = await _client
        .from('companies')
        .select()
        .eq('id', companyId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return CompanyModel.fromJson(response);
  }

  /// Update Company
  Future<void> updateCompany({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    await _client
        .from('companies')
        .update(data)
        .eq('id', id);
  }

  /// Delete Company
  Future<void> deleteCompany(String id) async {
    await _client
        .from('companies')
        .delete()
        .eq('id', id);
  }
}