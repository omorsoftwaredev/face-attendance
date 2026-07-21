import 'package:flutter/material.dart';

class EmployeeDepartment extends StatelessWidget {
  const EmployeeDepartment({
    super.key,
    required this.departmentId,
    required this.isActive,
    required this.onDepartmentChanged,
    required this.onStatusChanged,
  });

  final String? departmentId;
  final bool isActive;

  final ValueChanged<String?> onDepartmentChanged;
  final ValueChanged<bool> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Department',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        DropdownButtonFormField<String>(
          value: departmentId,
          isExpanded: true,
          decoration: const InputDecoration(
            labelText: 'Department',
            prefixIcon: Icon(Icons.apartment_outlined),
            border: OutlineInputBorder(),
          ),

          /// Sprint-09
          /// Dynamic Departments from Provider
          items: const [
            DropdownMenuItem(
              value: 'hr',
              child: Text('Human Resource'),
            ),
            DropdownMenuItem(
              value: 'accounts',
              child: Text('Accounts'),
            ),
            DropdownMenuItem(
              value: 'marketing',
              child: Text('Marketing'),
            ),
            DropdownMenuItem(
              value: 'development',
              child: Text('Development'),
            ),
            DropdownMenuItem(
              value: 'support',
              child: Text('Support'),
            ),
          ],

          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a department';
            }

            return null;
          },

          onChanged: onDepartmentChanged,
        ),

        const SizedBox(height: 24),

        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                Icon(
                  isActive
                      ? Icons.verified_user_outlined
                      : Icons.person_off_outlined,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Employee Status',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall,
                      ),

                      Text(
                        isActive
                            ? 'Employee can use the system.'
                            : 'Employee account is disabled.',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ],
                  ),
                ),

                Switch(
                  value: isActive,
                  onChanged: onStatusChanged,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}