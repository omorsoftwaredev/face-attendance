import 'package:flutter/material.dart';

import 'package:worktrack_pro/core/models/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onEdit,
    required this.onDelete,
  });

  final EmployeeModel employee;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                  theme.colorScheme.primaryContainer,
                  backgroundImage: employee.profilePhoto != null &&
                      employee.profilePhoto!.isNotEmpty
                      ? NetworkImage(
                    employee.profilePhoto!,
                  )
                      : null,
                  child: employee.profilePhoto == null ||
                      employee.profilePhoto!.isEmpty
                      ? Text(
                    employee.fullName
                        .trim()
                        .substring(0, 1)
                        .toUpperCase(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : null,
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.fullName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        employee.employeeCode,
                        style: theme.textTheme.bodySmall,
                      ),

                      if (employee.designationName != null &&
                          employee.designationName!.isNotEmpty)
                        Padding(
                          padding:
                          const EdgeInsets.only(top: 4),
                          child: Text(
                            employee.designationName!,
                            style:
                            theme.textTheme.bodyMedium,
                          ),
                        ),
                    ],
                  ),
                ),

                _StatusBadge(
                  isActive: employee.isActive,
                ),
              ],
            ),

            const SizedBox(height: 18),

            if (employee.email != null &&
                employee.email!.isNotEmpty)
              _InfoTile(
                icon: Icons.email_outlined,
                text: employee.email!,
              ),

            if (employee.phone != null &&
                employee.phone!.isNotEmpty)
              _InfoTile(
                icon: Icons.phone_outlined,
                text: employee.phone!,
              ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [
                FilledButton.tonalIcon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text("Edit"),
                ),

                const SizedBox(width: 12),

                FilledButton.tonalIcon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline),
                  label: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withValues(alpha: 0.12)
            : theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? "Active" : "Inactive",
        style: TextStyle(
          color: isActive
              ? Colors.green
              : theme.colorScheme.onErrorContainer,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}