import 'package:flutter/material.dart';

class AttendanceNotesSection extends StatelessWidget {
  const AttendanceNotesSection({
    super.key,
    required this.notesController,
  });

  final TextEditingController notesController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: notesController,
          maxLines: 4,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Notes',
            hintText: 'Optional notes...',
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
            prefixIcon: Icon(Icons.note_alt_outlined),
          ),
        ),
      ),
    );
  }
}