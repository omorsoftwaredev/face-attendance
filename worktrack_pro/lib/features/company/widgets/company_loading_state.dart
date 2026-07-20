import 'package:flutter/material.dart';

class CompanyLoadingState extends StatelessWidget {
  final String message;

  const CompanyLoadingState({
    super.key,
    this.message = 'Loading companies...',
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
            SizedBox(
              height: 56,
              width: 56,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: theme
                    .colorScheme
                    .primary,
              ),
            ),

            const SizedBox(
              height: 24,
            ),

            Text(
              message,
              textAlign: TextAlign.center,
              style: theme
                  .textTheme
                  .bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}