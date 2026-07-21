import 'package:flutter/material.dart';

class EmployeeBasicInfo extends StatelessWidget {
  const EmployeeBasicInfo({
    super.key,
    required this.employeeCodeController,
    required this.fullNameController,
    required this.designationController,
  });

  final TextEditingController employeeCodeController;
  final TextEditingController fullNameController;
  final TextEditingController designationController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: employeeCodeController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Employee Code',
            hintText: 'EMP-0001',
            prefixIcon: Icon(Icons.badge_outlined),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Employee Code is required';
            }

            if (value.trim().length < 3) {
              return 'Employee Code is too short';
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: fullNameController,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            hintText: 'John Doe',
            prefixIcon: Icon(Icons.person_outline),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Full Name is required';
            }

            if (value.trim().length < 3) {
              return 'Please enter a valid name';
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: designationController,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Designation',
            hintText: 'Software Engineer',
            prefixIcon: Icon(Icons.work_outline),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Designation is required';
            }

            return null;
          },
        ),
      ],
    );
  }
}