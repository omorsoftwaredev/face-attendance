import 'package:flutter/material.dart';

import '../models/designation_model.dart';

class DesignationCard extends StatelessWidget {
  const DesignationCard({
    super.key,
    required this.designation,
    required this.onEdit,
    required this.onDelete,
  });

  final DesignationModel designation;
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
            designation.designationName
                .substring(0, 1)
                .toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme
                  .colorScheme
                  .onPrimaryContainer,
            ),
          ),
        ),
        title: Text(
          designation.designationName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            if (designation.description != null &&
                designation
                    .description!
                    .isNotEmpty)
              Padding(
                padding:
                const EdgeInsets.only(
                  top: 4,
                ),
                child: Text(
                  designation.description!,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                ),
              ),

            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                Chip(
                  visualDensity:
                  VisualDensity.compact,
                  avatar: Icon(
                    designation.isActive
                        ? Icons.check_circle
                        : Icons.cancel,
                    size: 16,
                  ),
                  label: Text(
                    designation.isActive
                        ? 'Active'
                        : 'Inactive',
                  ),
                ),

                if (designation.departmentId != null)
                  Chip(
                    visualDensity:
                    VisualDensity.compact,
                    avatar: const Icon(
                      Icons.apartment_outlined,
                      size: 16,
                    ),
                    label: const Text(
                      'Department',
                    ),
                  ),
              ],
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