import 'package:flutter/material.dart';

import '../models/shift_model.dart';

class ShiftCard extends StatelessWidget {
  const ShiftCard({
    super.key,
    required this.shift,
    required this.onEdit,
    required this.onDelete,
  });

  final ShiftModel shift;
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
          child: const Icon(
            Icons.schedule,
          ),
        ),
        title: Text(
          shift.shiftName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            Text(
              '${shift.startTime}  →  ${shift.endTime}',
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
                    shift.isActive
                        ? Icons.check_circle
                        : Icons.cancel,
                    size: 16,
                  ),
                  label: Text(
                    shift.isActive
                        ? 'Active'
                        : 'Inactive',
                  ),
                ),

                if (shift.isNightShift)
                  const Chip(
                    visualDensity:
                    VisualDensity.compact,
                    avatar: Icon(
                      Icons.nightlight_round,
                      size: 16,
                    ),
                    label: Text(
                      'Night Shift',
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