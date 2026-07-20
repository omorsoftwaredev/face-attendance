import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/models/company_model.dart';
import '../providers/company_provider.dart';


class CompanyFormPage extends StatefulWidget {
  final CompanyModel? company;

  const CompanyFormPage({
    super.key,
    this.company,
  });

  @override
  State<CompanyFormPage> createState() =>
      _CompanyFormPageState();
}

class _CompanyFormPageState extends State<CompanyFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _addressController;

  bool _isSaving = false;

  bool get isEditMode => widget.company != null;

  @override
  void initState() {
    super.initState();

    final company = widget.company;

    _nameController = TextEditingController(
      text: company?.companyName ?? '',
    );

    _emailController = TextEditingController(
      text: company?.companyEmail ?? '',
    );

    _phoneController = TextEditingController(
      text: company?.phone ?? '',
    );

    _addressController = TextEditingController(
      text: company?.address ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();

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
    context.read<CompanyProvider>();

    bool success;

    if (isEditMode) {
      success = await provider.updateCompany(
        id: widget.company!.id,
        companyName:
        _nameController.text.trim(),
        companyEmail:
        _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        phone:
        _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        address:
        _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(),
        logoUrl: widget.company!.logoUrl,
        isActive: widget.company!.isActive,
      );
    } else {
      success = await provider.createCompany(
        companyName:
        _nameController.text.trim(),
        companyEmail:
        _emailController.text.trim().isEmpty
            ? null
            : _emailController.text.trim(),
        phone:
        _phoneController.text.trim().isEmpty
            ? null
            : _phoneController.text.trim(),
        address:
        _addressController.text.trim().isEmpty
            ? null
            : _addressController.text.trim(),
      );
    }

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (success) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            isEditMode
                ? 'Company updated successfully'
                : 'Company created successfully',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            provider.error ??
                'Something went wrong',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode
              ? 'Edit Company'
              : 'Create Company',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration:
                const InputDecoration(
                  labelText: 'Company Name',
                  prefixIcon:
                  Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Company name required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _emailController,
                keyboardType:
                TextInputType.emailAddress,
                decoration:
                const InputDecoration(
                  labelText: 'Email',
                  prefixIcon:
                  Icon(Icons.email_outlined),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _phoneController,
                keyboardType:
                TextInputType.phone,
                decoration:
                const InputDecoration(
                  labelText: 'Phone',
                  prefixIcon:
                  Icon(Icons.phone_outlined),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration:
                const InputDecoration(
                  labelText: 'Address',
                  prefixIcon:
                  Icon(Icons.location_on),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed:
                  _isSaving ? null : _save,
                  icon: _isSaving
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : const Icon(
                    Icons.save,
                  ),
                  label: Text(
                    _isSaving
                        ? 'Saving...'
                        : 'Save Company',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}