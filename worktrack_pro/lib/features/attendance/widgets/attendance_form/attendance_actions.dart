import 'package:flutter/material.dart';

class AttendanceActions extends StatelessWidget {
  const AttendanceActions({
    super.key,
    required this.isLoading,
    required this.isEdit,
    required this.onSave,
    required this.onCancel,
  });

  final bool isLoading;
  final bool isEdit;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: isLoading
                ? null
                : onCancel,
            child: const Text(
              'Cancel',
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: FilledButton.icon(
            onPressed: isLoading
                ? null
                : onSave,
            icon: isLoading
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
                : Icon(
              isEdit
                  ? Icons.save
                  : Icons.add,
            ),
            label: Text(
              isEdit
                  ? 'Update'
                  : 'Create',
            ),
          ),
        ),
      ],
    );
  }
}