import 'package:flutter/material.dart';

class EmployeeContact extends StatelessWidget {
  const EmployeeContact({
    super.key,
    required this.emailController,
    required this.phoneController,
  });

  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'employee@company.com',
            prefixIcon: Icon(Icons.email_outlined),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            final email = value?.trim() ?? '';

            if (email.isEmpty) {
              return null;
            }

            final emailRegex = RegExp(
              r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
            );

            if (!emailRegex.hasMatch(email)) {
              return 'Please enter a valid email address';
            }

            return null;
          },
        ),

        const SizedBox(height: 16),

        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: '+8801XXXXXXXXX',
            prefixIcon: Icon(Icons.phone_outlined),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            final phone = value?.trim() ?? '';

            if (phone.isEmpty) {
              return null;
            }

            if (phone.length < 11) {
              return 'Please enter a valid phone number';
            }

            return null;
          },
        ),
      ],
    );
  }
}