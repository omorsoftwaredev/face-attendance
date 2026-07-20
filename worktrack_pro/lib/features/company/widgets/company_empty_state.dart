import 'package:flutter/material.dart';

class CompanyEmptyState extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onAction;
  final String actionLabel;

  const CompanyEmptyState({
    super.key,
    this.title = 'No Companies Found',
    this.message =
    'Create your first company to start managing your workspace.',
    this.onAction,
    this.actionLabel = 'Create Company',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Container(
              height: 96,
              width: 96,
              decoration: BoxDecoration(
                color: theme
                    .colorScheme
                    .primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.business_outlined,
                size: 48,
                color: theme
                    .colorScheme
                    .onPrimaryContainer,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Text(
              title,
              textAlign: TextAlign.center,
              style: theme
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              message,
              textAlign: TextAlign.center,
              style: theme
                  .textTheme
                  .bodyMedium,
            ),

            if (onAction != null) ...[
              const SizedBox(
                height: 24,
              ),

              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(
                  Icons.add,
                ),
                label: Text(
                  actionLabel,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}