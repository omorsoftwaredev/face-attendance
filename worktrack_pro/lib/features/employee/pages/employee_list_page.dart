import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/employee_provider.dart';
import '../widgets/employee_card.dart';
import 'employee_form_page.dart';

class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() =>
      _EmployeeListPageState();
}

class _EmployeeListPageState
    extends State<EmployeeListPage> {
  final TextEditingController _searchController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeProvider>().loadEmployees();
    });

    _searchController.addListener(() {
      context
          .read<EmployeeProvider>()
          .search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await context
        .read<EmployeeProvider>()
        .loadEmployees();
  }

  @override
  Widget build(BuildContext context) {
    final provider =
    context.watch<EmployeeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
      ),

      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const EmployeeFormPage(),
            ),
          ).then((_) => _refresh());
        },
        icon: const Icon(Icons.add),
        label: const Text('Employee'),
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
              hintText: 'Search employee...',
              leading:
              const Icon(Icons.search),

              trailing:
              _searchController.text.isEmpty
                  ? null
                  : [
                IconButton(
                  onPressed: () {
                    _searchController
                        .clear();
                  },
                  icon: const Icon(
                    Icons.close,
                  ),
                ),
              ],
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
                    provider.employees.isEmpty) {
                  return Center(
                    child: Padding(
                      padding:
                      const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 70,
                          ),

                          const SizedBox(
                              height: 16),

                          Text(
                            provider.error!,
                            textAlign:
                            TextAlign.center,
                          ),

                          const SizedBox(
                              height: 20),

                          FilledButton.icon(
                            onPressed: _refresh,
                            icon: const Icon(
                              Icons.refresh,
                            ),
                            label: const Text(
                              'Retry',
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (provider
                    .filteredEmployees
                    .isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: const [
                        SizedBox(
                          height: 180,
                        ),
                        Icon(
                          Icons.people_outline,
                          size: 80,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: Text(
                            'No Employees Found',
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child:
                  ListView.separated(
                    padding:
                    const EdgeInsets.only(
                      top: 8,
                      bottom: 90,
                    ),

                    itemCount: provider
                        .filteredEmployees
                        .length,

                    separatorBuilder:
                        (_, __) =>
                    const SizedBox(
                      height: 4,
                    ),

                    itemBuilder:
                        (_, index) {
                      final employee =
                      provider
                          .filteredEmployees[
                      index];

                      return EmployeeCard(
                        employee: employee,

                        onEdit: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  EmployeeFormPage(
                                    employeeId:
                                    employee.id,
                                  ),
                            ),
                          ).then(
                                (_) => _refresh(),
                          );
                        },

                        onDelete: () async {
                          final confirm =
                          await showDialog<
                              bool>(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  title: const Text(
                                    'Delete Employee',
                                  ),
                                  content:
                                  Text(
                                    'Delete ${employee.fullName}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                          context,
                                          false,
                                        );
                                      },
                                      child:
                                      const Text(
                                        'Cancel',
                                      ),
                                    ),
                                    FilledButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                          context,
                                          true,
                                        );
                                      },
                                      child:
                                      const Text(
                                        'Delete',
                                      ),
                                    ),
                                  ],
                                ),
                          );

                          if (confirm ==
                              true) {
                            await provider
                                .deleteEmployee(
                              employee.id,
                            );

                            if (context
                                .mounted) {
                              ScaffoldMessenger
                                  .of(
                                  context)
                                  .showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Employee deleted successfully.',
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