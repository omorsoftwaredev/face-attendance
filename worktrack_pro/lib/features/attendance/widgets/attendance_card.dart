import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/models/attendance_model.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.attendance,
    required this.onEdit,
    required this.onDelete,
  });

  final AttendanceModel attendance;
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
          child: const Icon(Icons.fact_check),
        ),
        title: Text(
          DateFormat(
            'dd MMM yyyy',
          ).format(attendance.attendanceDate),
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
              'Status: ${attendance.attendanceStatus}',
            ),

            const SizedBox(height: 4),

            Text(
              'In: ${_formatDateTime(attendance.checkInTime)}',
            ),

            Text(
              'Out: ${_formatDateTime(attendance.checkOutTime)}',
            ),

            const SizedBox(height: 6),

            Wrap(
              spacing: 8,
              children: [
                Chip(
                  label: Text(
                    'Late ${attendance.lateMinutes}m',
                  ),
                ),
                Chip(
                  label: Text(
                    'Work ${attendance.workedMinutes}m',
                  ),
                ),
                Chip(
                  label: Text(
                    'OT ${attendance.overtimeMinutes}m',
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

  String _formatDateTime(DateTime? value) {
    if (value == null) {
      return '-';
    }

    return DateFormat(
      'hh:mm a',
    ).format(value);
  }
}