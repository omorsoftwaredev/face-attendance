import 'package:flutter/material.dart';

import '../../../core/models/employee_model.dart';
import 'employee_form_page.dart';

class EmployeeDetailPage extends StatelessWidget {
  const EmployeeDetailPage({
    super.key,
    required this.employee,
  });

  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        actions: [
          IconButton(
            tooltip: 'Edit',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmployeeFormPage(
                    employeeId: employee.id,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer,
                    child: employee.profilePhoto == null
                        ? Text(
                      employee.fullName.isNotEmpty
                          ? employee.fullName
                          .substring(0, 1)
                          .toUpperCase()
                          : '?',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                        : const Icon(
                      Icons.person,
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    employee.fullName,
                    style: theme.textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 6),

                  Text(
                    employee.designationName ?? '-',
                    style: theme.textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 14),

                  Chip(
                    avatar: Icon(
                      employee.isActive
                          ? Icons.check_circle_outline
                          : Icons.cancel_outlined,
                      size: 18,
                    ),
                    label: Text(
                      employee.isActive
                          ? 'Active'
                          : 'Inactive',
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          _InfoTile(
            icon: Icons.badge_outlined,
            title: 'Employee Code',
            value: employee.employeeCode,
          ),

          _InfoTile(
            icon: Icons.email_outlined,
            title: 'Email',
            value: employee.email ?? '-',
          ),

          _InfoTile(
            icon: Icons.phone_outlined,
            title: 'Phone',
            value: employee.phone ?? '-',
          ),

          _InfoTile(
            icon: Icons.business_outlined,
            title: 'Company ID',
            value: employee.companyId,
          ),

          _InfoTile(
            icon: Icons.apartment_outlined,
            title: 'Department ID',
            value: employee.departmentId ?? '-',
          ),

          _InfoTile(
            icon: Icons.work_outline,
            title: 'Designation',
            value: employee.designationName ?? '-',
          ),

          _InfoTile(
            icon: Icons.person_outline,
            title: 'Status',
            value: employee.isActive
                ? 'Active'
                : 'Inactive',
          ),

          _InfoTile(
            icon: Icons.calendar_today_outlined,
            title: 'Created At',
            value: employee.createdAt.toLocal().toString(),
          ),

          _InfoTile(
            icon: Icons.update_outlined,
            title: 'Updated At',
            value: employee.updatedAt.toLocal().toString(),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}