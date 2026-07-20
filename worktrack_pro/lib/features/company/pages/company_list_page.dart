import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/company_provider.dart';
import '../widgets/company_card.dart';

class CompanyListPage extends StatefulWidget {
  const CompanyListPage({super.key});

  @override
  State<CompanyListPage> createState() => _CompanyListPageState();
}

class _CompanyListPageState extends State<CompanyListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CompanyProvider>().loadCompanies();
    });

    _searchController.addListener(() {
      context.read<CompanyProvider>().search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context.read<CompanyProvider>().loadCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CompanyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Companies'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              16,
              16,
              16,
              8,
            ),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search company...',
              leading: const Icon(Icons.search),
              trailing: _searchController.text.isEmpty
                  ? null
                  : [
                IconButton(
                  onPressed: () {
                    _searchController.clear();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (provider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.error != null &&
                    provider.companies.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            provider.error!,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          FilledButton.icon(
                            onPressed: _refresh,
                            icon: const Icon(Icons.refresh),
                            label: const Text("Retry"),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (provider.filteredCompanies.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: const [
                        SizedBox(height: 180),
                        Icon(
                          Icons.business_outlined,
                          size: 72,
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            "No companies found",
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount:
                    provider.filteredCompanies.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                    itemBuilder: (_, index) {
                      final company =
                      provider.filteredCompanies[index];

                      return CompanyCard(
                        company: company,
                        onEdit: () {},
                        onDelete: () async {
                          await provider.deleteCompany(company.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Create Company page will be added in next sprint.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Company"),
      ),
    );
  }
}