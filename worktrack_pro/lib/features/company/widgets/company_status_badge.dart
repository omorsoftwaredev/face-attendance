import 'package:flutter/material.dart';

class CompanyStatusBadge extends StatelessWidget {
  final bool isActive;

  const CompanyStatusBadge({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final backgroundColor = isActive
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.errorContainer;

    final foregroundColor = isActive
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onErrorContainer;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            size: 16,
            color: foregroundColor,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            isActive
                ? 'Active'
                : 'Inactive',
            style: theme.textTheme.labelMedium?.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}