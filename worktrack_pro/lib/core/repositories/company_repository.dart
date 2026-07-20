import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:worktrack_pro/core/models/company_model.dart';

class CompanyRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> createCompany(CompanyModel company) async {
    await _client.from('companies').insert(company.toJson());
  }

  Future<CompanyModel?> getCompany() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      return null;
    }

    final response = await _client
        .from('companies')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return CompanyModel.fromJson(response);
  }

  Future<void> updateCompany(
      String id,
      Map<String, dynamic> data,
      ) async {
    await _client
        .from('companies')
        .update(data)
        .eq('id', id);
  }

  Future<void> deleteCompany(String id) async {
    await _client
        .from('companies')
        .delete()
        .eq('id', id);
  }
}