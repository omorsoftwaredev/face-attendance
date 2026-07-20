import 'package:flutter/material.dart';

class CompanyInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const CompanyInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              size: 22,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme
                      .textTheme
                      .labelMedium
                      ?.copyWith(
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  value,
                  style: theme
                      .textTheme
                      .bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}