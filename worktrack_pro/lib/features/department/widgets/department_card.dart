import 'package:flutter/material.dart';

import '../models/department_model.dart';

class DepartmentCard extends StatelessWidget {
  const DepartmentCard({
    super.key,
    required this.department,
    required this.onEdit,
    required this.onDelete,
  });

  final DepartmentModel department;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
          theme.colorScheme.primaryContainer,
          child: Text(
            department.departmentName
                .substring(0, 1)
                .toUpperCase(),
            style: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          department.departmentName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            if (department.description != null &&
                department.description!.isNotEmpty)
              Padding(
                padding:
                const EdgeInsets.only(top: 4),
                child: Text(
                  department.description!,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                ),
              ),

            const SizedBox(height: 6),

            Chip(
              label: Text(
                department.isActive
                    ? 'Active'
                    : 'Inactive',
              ),
              visualDensity:
              VisualDensity.compact,
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit();
                break;

              case 'delete':
                onDelete();
                break;
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(width: 8),
                  Text('Edit'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline),
                  SizedBox(width: 8),
                  Text('Delete'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}