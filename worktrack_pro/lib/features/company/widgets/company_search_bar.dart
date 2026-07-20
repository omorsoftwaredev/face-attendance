import 'package:flutter/material.dart';

class CompanySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hintText;

  const CompanySearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.hintText = 'Search company...',
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: hintText,
      leading: const Icon(
        Icons.search,
      ),
      onChanged: onChanged,
      trailing: [
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (
              context,
              value,
              child,
              ) {
            if (value.text.isEmpty) {
              return const SizedBox.shrink();
            }

            return IconButton(
              onPressed: () {
                controller.clear();

                onChanged?.call('');
              },
              icon: const Icon(
                Icons.close,
              ),
            );
          },
        ),
      ],
    );
  }
}