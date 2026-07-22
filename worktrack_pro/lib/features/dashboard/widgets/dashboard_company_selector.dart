import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../company/providers/company_provider.dart';

class DashboardCompanySelector extends StatelessWidget {
  const DashboardCompanySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();

    final companies = provider.companies;
    final selected = provider.selectedCompany;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.business),
                SizedBox(width: 8),
                Text(
                  'Current Company',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (companies.isEmpty)
              const ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.warning_amber),
                title: Text(
                  'No Company Found',
                ),
                subtitle: Text(
                  'Please create a company first.',
                ),
              )
            else
              DropdownButtonFormField<String>(
                value: selected?.id,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Company',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                items: companies.map((company) {
                  return DropdownMenuItem<String>(
                    value: company.id,
                    child: Text(
                      company.companyName,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;

                  final company = companies.firstWhere(
                        (e) => e.id == value,
                  );

                  provider.selectCompany(company);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        'Current Company: ${company.companyName}',
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}