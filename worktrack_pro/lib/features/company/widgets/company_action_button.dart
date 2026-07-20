import 'package:flutter/material.dart';

class CompanyActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CompanyActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bgColor = backgroundColor ??
        (isPrimary
            ? theme.colorScheme.primary
            : theme.colorScheme.secondaryContainer);

    final fgColor = foregroundColor ??
        (isPrimary
            ? theme.colorScheme.onPrimary
            : theme.colorScheme.onSecondaryContainer);

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading)
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
        else
          Icon(
            icon,
            size: 18,
          ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );

    if (isPrimary) {
      return FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          minimumSize: const Size(120, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: child,
      );
    }

    return FilledButton.tonal(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        minimumSize: const Size(120, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: child,
    );
  }
}