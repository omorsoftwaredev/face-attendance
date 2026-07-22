import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../company/providers/company_provider.dart';
import '../providers/designation_provider.dart';
import '../widgets/designation_card.dart';
import 'designation_form_page.dart';

class DesignationListPage extends StatefulWidget {
  const DesignationListPage({super.key});

  @override
  State<DesignationListPage> createState() =>
      _DesignationListPageState();
}

class _DesignationListPageState
    extends State<DesignationListPage> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final company = context
          .read<CompanyProvider>()
          .selectedCompany;

      if (company != null) {
        context
            .read<DesignationProvider>()
            .loadDesignations(
          companyId: company.id,
        );
      }
    });

    _searchController.addListener(() {
      context
          .read<DesignationProvider>()
          .search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final company = context
        .read<CompanyProvider>()
        .selectedCompany;

    if (company == null) return;

    await context
        .read<DesignationProvider>()
        .refresh(
      companyId: company.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<DesignationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Designations',
        ),
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const DesignationFormPage(),
            ),
          );

          if (mounted) {
            await _refresh();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Designation',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText:
              'Search designation...',
              leading: const Icon(
                Icons.search,
              ),
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (provider.isLoading) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (provider.error != null &&
                    provider.designations.isEmpty) {
                  return Center(
                    child: Text(
                      provider.error!,
                    ),
                  );
                }

                if (provider
                    .filteredDesignations
                    .isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: const [
                        SizedBox(height: 180),
                        Icon(
                          Icons.badge_outlined,
                          size: 80,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'No Designation Found',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    padding:
                    const EdgeInsets.only(
                      bottom: 90,
                    ),
                    itemCount: provider
                        .filteredDesignations
                        .length,
                    itemBuilder:
                        (_, index) {
                      final designation =
                      provider.filteredDesignations[index];

                      return DesignationCard(
                        designation: designation,
                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DesignationFormPage(
                                    designationId:
                                    designation.id,
                                    departmentId:
                                    designation
                                        .departmentId,
                                  ),
                            ),
                          );

                          if (mounted) {
                            await _refresh();
                          }
                        },
                        onDelete: () async {
                          final confirm =
                          await showDialog<bool>(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  title: const Text(
                                    'Delete Designation',
                                  ),
                                  content: Text(
                                    'Delete "${designation.designationName}" ?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          false,
                                        );
                                      },
                                      child: const Text(
                                        'Cancel',
                                      ),
                                    ),
                                    FilledButton(
                                      onPressed: () {
                                        Navigator.pop(
                                          context,
                                          true,
                                        );
                                      },
                                      child: const Text(
                                        'Delete',
                                      ),
                                    ),
                                  ],
                                ),
                          );

                          if (confirm == true) {
                            final success =
                            await provider
                                .deleteDesignation(
                              designation.id,
                            );

                            if (!mounted) {
                              return;
                            }

                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? 'Designation deleted successfully.'
                                      : provider.error ??
                                      'Delete failed.',
                                ),
                              ),
                            );
                          }
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
    );
  }
}