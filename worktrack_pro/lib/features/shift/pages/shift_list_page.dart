import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../company/providers/company_provider.dart';
import '../providers/shift_provider.dart';
import '../widgets/shift_card.dart';
import 'shift_form_page.dart';

class ShiftListPage extends StatefulWidget {
  const ShiftListPage({super.key});

  @override
  State<ShiftListPage> createState() => _ShiftListPageState();
}

class _ShiftListPageState extends State<ShiftListPage> {
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
        context.read<ShiftProvider>().loadShifts(
          companyId: company.id,
        );
      }
    });

    _searchController.addListener(() {
      context.read<ShiftProvider>().search(
        _searchController.text,
      );
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

    await context.read<ShiftProvider>().refresh(
      companyId: company.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ShiftProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shifts'),
      ),
      floatingActionButton:
      FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const ShiftFormPage(),
            ),
          );

          if (mounted) {
            _refresh();
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Shift'),
      ),
      body: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.all(16),
            child: SearchBar(
              controller: _searchController,
              hintText: 'Search shift...',
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

                if (provider.filteredShifts
                    .isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView(
                      children: const [
                        SizedBox(height: 180),
                        Icon(
                          Icons.schedule,
                          size: 80,
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                            'No Shift Found',
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
                        .filteredShifts.length,
                    itemBuilder: (_, index) {
                      final shift = provider
                          .filteredShifts[index];

                      return ShiftCard(
                        shift: shift,
                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ShiftFormPage(
                                    shiftId: shift.id,
                                  ),
                            ),
                          );

                          if (mounted) {
                            _refresh();
                          }
                        },
                        onDelete: () async {
                          final confirm =
                          await showDialog<bool>(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  title: const Text(
                                    'Delete Shift',
                                  ),
                                  content: Text(
                                    'Delete "${shift.shiftName}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
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
                                      onPressed: () {
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

                          if (confirm == true) {
                            final success =
                            await provider
                                .deleteShift(
                              shift.id,
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
                                      ? 'Shift deleted successfully.'
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