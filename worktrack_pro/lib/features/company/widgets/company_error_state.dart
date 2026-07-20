import 'package:flutter/material.dart';

class CompanyErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const CompanyErrorState({
    super.key,
    required this.message,
    this.onRetry,
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
                    .errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 48,
                color: theme
                    .colorScheme
                    .onErrorContainer,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Text(
              'Something went wrong',
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

            if (onRetry != null) ...[
              const SizedBox(
                height: 24,
              ),

              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(
                  Icons.refresh,
                ),
                label: const Text(
                  'Retry',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}