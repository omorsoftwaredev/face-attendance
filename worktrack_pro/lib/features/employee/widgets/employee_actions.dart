import 'package:flutter/material.dart';

class EmployeeActions extends StatelessWidget {
  const EmployeeActions({
    super.key,
    required this.isEdit,
    required this.onSave,
    this.isLoading = false,
    this.onCancel,
  });

  final bool isEdit;
  final bool isLoading;

  final VoidCallback onSave;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: FilledButton.icon(
            onPressed: isLoading ? null : onSave,
            icon: isLoading
                ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            )
                : Icon(
              isEdit
                  ? Icons.save_outlined
                  : Icons.person_add_alt_1_outlined,
            ),
            label: Text(
              isEdit
                  ? 'Update Employee'
                  : 'Create Employee',
            ),
          ),
        ),

        if (onCancel != null) ...[
          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton.icon(
              onPressed: isLoading ? null : onCancel,
              icon: const Icon(Icons.close),
              label: const Text(
                'Cancel',
              ),
            ),
          ),
        ],
      ],
    );
  }
}