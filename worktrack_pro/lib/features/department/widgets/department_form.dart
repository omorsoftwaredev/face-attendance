import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../company/providers/company_provider.dart';
import '../models/department_model.dart';
import '../providers/department_provider.dart';

class DepartmentForm extends StatefulWidget {
  const DepartmentForm({
    super.key,
    this.departmentId,
  });

  final String? departmentId;

  @override
  State<DepartmentForm> createState() => _DepartmentFormState();
}

class _DepartmentFormState extends State<DepartmentForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isActive = true;
  bool _isSaving = false;

  bool get isEdit => widget.departmentId != null;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final provider = context.read<DepartmentProvider>();

    final company = context
        .read<CompanyProvider>()
        .selectedCompany;

    if (company == null) {
      setState(() {
        _isSaving = false;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a company.',
          ),
        ),
      );

      return;
    }

    final now = DateTime.now();

    final department = DepartmentModel(
      id: widget.departmentId ?? const Uuid().v4(),
      companyId: company.id,
      departmentName: _nameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      isActive: _isActive,
      createdAt: now,
      updatedAt: now,
    );

    bool success;

    if (isEdit) {
      success = await provider.updateDepartment(
        department: department,
      );
    } else {
      success = await provider.createDepartment(
        department: department,
      );
    }

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isEdit
                ? 'Department updated successfully.'
                : 'Department created successfully.',
          ),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.error ?? 'Something went wrong.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Department Name',
                prefixIcon: Icon(Icons.apartment_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Department name is required.';
                }

                if (value.trim().length < 2) {
                  return 'Minimum 2 characters required.';
                }

                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.description_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: SwitchListTile(
                title: const Text(
                  'Department Active',
                ),
                subtitle: const Text(
                  'Inactive departments will be hidden.',
                ),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: _isSaving ? null : _save,
                icon: _isSaving
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
                    : Icon(
                  isEdit
                      ? Icons.save_outlined
                      : Icons.add,
                ),
                label: Text(
                  isEdit
                      ? 'Update Department'
                      : 'Create Department',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}