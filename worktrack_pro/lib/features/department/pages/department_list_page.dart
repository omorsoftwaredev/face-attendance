import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/department_provider.dart';
import '../widgets/department_card.dart';
import 'department_form_page.dart';

class DepartmentListPage extends StatefulWidget {
  const DepartmentListPage({super.key});

  @override
  State<DepartmentListPage> createState() =>
      _DepartmentListPageState();
}

class _DepartmentListPageState
    extends State<DepartmentListPage> {
  final TextEditingController _searchController =
  TextEditingController();

  /// TODO:
  /// Replace with current CompanyProvider selected company id
  final String companyId = 'YOUR_COMPANY_ID';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DepartmentProvider>().loadDepartments(
        companyId: companyId,
      );
    });

    _searchController.addListener(() {
      context
          .read<DepartmentProvider>()
          .search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context.read<DepartmentProvider>().refresh(
      companyId: companyId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<DepartmentProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Departments',
        ),
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const DepartmentFormPage(),
            ),
          );

          _refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Department',
        ),
      ),

      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText:
              'Search department...',
              leading:
              const Icon(Icons.search),
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
                    provider.departments.isEmpty) {
                  return Center(
                    child: Text(
                      provider.error!,
                    ),
                  );
                }

                if (provider
                    .filteredDepartments
                    .isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: const [

                        SizedBox(height: 180),

                        Icon(
                          Icons.apartment_outlined,
                          size: 80,
                        ),

                        SizedBox(height: 20),

                        Center(
                          child: Text(
                            'No Department Found',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child:
                  ListView.builder(
                    padding:
                    const EdgeInsets.only(
                      bottom: 90,
                    ),

                    itemCount: provider
                        .filteredDepartments
                        .length,

                    itemBuilder:
                        (_, index) {

                      final department =
                      provider
                          .filteredDepartments[index];

                      return DepartmentCard(

                        department: department,

                        onEdit: () async {

                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DepartmentFormPage(
                                    departmentId:
                                    department.id,
                                  ),
                            ),
                          );

                          _refresh();
                        },

                        onDelete: () async {

                          final confirm =
                          await showDialog<bool>(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  title: const Text(
                                    'Delete Department',
                                  ),
                                  content: Text(
                                    'Delete "${department.departmentName}" ?',
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

                            await provider
                                .deleteDepartment(
                              department.id,
                            );

                            if (mounted) {

                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Department deleted successfully.',
                                  ),
                                ),
                              );
                            }
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