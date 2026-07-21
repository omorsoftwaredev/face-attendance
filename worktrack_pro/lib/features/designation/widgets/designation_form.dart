import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/designation_model.dart';
import '../providers/designation_provider.dart';

class DesignationForm extends StatefulWidget {
  const DesignationForm({
    super.key,
    this.designationId,
    this.departmentId,
  });

  final String? designationId;
  final String? departmentId;

  @override
  State<DesignationForm> createState() =>
      _DesignationFormState();
}

class _DesignationFormState
    extends State<DesignationForm> {
  final _formKey = GlobalKey<FormState>();

  final _designationController =
  TextEditingController();

  final _descriptionController =
  TextEditingController();

  bool _isActive = true;
  bool _isSaving = false;

  bool get isEdit =>
      widget.designationId != null;

  @override
  void dispose() {
    _designationController.dispose();
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

    final provider =
    context.read<DesignationProvider>();

    final now = DateTime.now();

    final designation = DesignationModel(
      id: widget.designationId ??
          const Uuid().v4(),

      /// TODO:
      /// Replace with CompanyProvider.selectedCompany.id
      companyId: 'YOUR_COMPANY_ID',

      departmentId: widget.departmentId,

      designationName:
      _designationController.text.trim(),

      description:
      _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),

      isActive: _isActive,

      createdAt: now,
      updatedAt: now,
    );

    bool success;

    if (isEdit) {
      success =
      await provider.updateDesignation(
        designation: designation,
      );
    } else {
      success =
      await provider.createDesignation(
        designation: designation,
      );
    }

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            isEdit
                ? 'Designation updated successfully.'
                : 'Designation created successfully.',
          ),
        ),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            provider.error ??
                'Something went wrong.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
      const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [

            TextFormField(
              controller:
              _designationController,
              textInputAction:
              TextInputAction.next,
              decoration:
              const InputDecoration(
                labelText:
                'Designation Name',
                prefixIcon: Icon(
                  Icons.badge_outlined,
                ),
                border:
                OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Designation name is required.';
                }

                if (value.trim().length <
                    2) {
                  return 'Minimum 2 characters required.';
                }

                return null;
              },
            ),

            const SizedBox(
              height: 16,
            ),

            TextFormField(
              controller:
              _descriptionController,
              maxLines: 4,
              decoration:
              const InputDecoration(
                labelText:
                'Description',
                alignLabelWithHint:
                true,
                prefixIcon: Icon(
                  Icons.description_outlined,
                ),
                border:
                OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Card(
              child: SwitchListTile(
                title: const Text(
                  'Designation Active',
                ),
                subtitle: const Text(
                  'Inactive designation cannot be assigned.',
                ),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            SizedBox(
              width: double.infinity,
              height: 52,
              child:
              FilledButton.icon(
                onPressed:
                _isSaving
                    ? null
                    : _save,
                icon: _isSaving
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child:
                  CircularProgressIndicator(
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
                      ? 'Update Designation'
                      : 'Create Designation',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}