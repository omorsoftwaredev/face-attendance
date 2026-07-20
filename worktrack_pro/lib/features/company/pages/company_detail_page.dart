import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/company_model.dart';
import '../providers/company_provider.dart';
import 'company_form_page.dart';

class CompanyDetailPage extends StatelessWidget {
  final CompanyModel company;

  const CompanyDetailPage({
    super.key,
    required this.company,
  });

  Future<void> _deleteCompany(
      BuildContext context,
      ) async {
    final confirm =
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Company',
          ),
          content: Text(
            'Are you sure you want to delete ${company.companyName}?',
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
        );
      },
    );

    if (confirm != true) {
      return;
    }

    final success =
    await context
        .read<CompanyProvider>()
        .deleteCompany(company.id);

    if (!context.mounted) return;

    if (success) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Company deleted successfully',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            context
                .read<CompanyProvider>()
                .error ??
                'Delete failed',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme =
    Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Company Details',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      CompanyFormPage(
                        company: company,
                      ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                  20,
                ),
              ),
              child: Padding(
                padding:
                const EdgeInsets.all(
                  20,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      company.companyName,
                      style: theme
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Chip(
                      label: Text(
                        company.isActive
                            ? 'Active'
                            : 'Inactive',
                      ),
                      avatar: Icon(
                        company.isActive
                            ? Icons.check_circle
                            : Icons.cancel,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            _DetailSection(
              title: 'Contact Information',
              children: [
                _DetailRow(
                  icon:
                  Icons.email_outlined,
                  label: 'Email',
                  value:
                  company.companyEmail ??
                      'Not available',
                ),
                _DetailRow(
                  icon:
                  Icons.phone_outlined,
                  label: 'Phone',
                  value:
                  company.phone ??
                      'Not available',
                ),
                _DetailRow(
                  icon:
                  Icons.location_on_outlined,
                  label: 'Address',
                  value:
                  company.address ??
                      'Not available',
                ),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            _DetailSection(
              title: 'System Information',
              children: [
                _DetailRow(
                  icon:
                  Icons.calendar_today_outlined,
                  label: 'Created',
                  value:
                  company.createdAt
                      .toLocal()
                      .toString(),
                ),
                _DetailRow(
                  icon:
                  Icons.update_outlined,
                  label: 'Updated',
                  value:
                  company.updatedAt
                      .toLocal()
                      .toString(),
                ),
              ],
            ),

            const SizedBox(
              height: 32,
            ),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style:
                FilledButton.styleFrom(
                  backgroundColor:
                  theme
                      .colorScheme
                      .error,
                ),
                onPressed: () =>
                    _deleteCompany(
                      context,
                    ),
                icon: const Icon(
                  Icons.delete_outline,
                ),
                label: const Text(
                  'Delete Company',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _DetailSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight:
                FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 22,
          ),

          const SizedBox(
            width: 12,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}