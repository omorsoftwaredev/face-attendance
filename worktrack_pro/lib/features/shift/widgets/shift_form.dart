import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/shift_model.dart';
import '../providers/shift_provider.dart';
import '../../company/providers/company_provider.dart';
class ShiftForm extends StatefulWidget {
  const ShiftForm({
    super.key,
    this.shiftId,
  });

  final String? shiftId;

  @override
  State<ShiftForm> createState() => _ShiftFormState();
}

class _ShiftFormState extends State<ShiftForm> {
  final _formKey = GlobalKey<FormState>();

  final _shiftNameController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  final _lateGraceController =
  TextEditingController(text: '15');

  final _earlyLeaveController =
  TextEditingController(text: '15');

  final _halfDayController =
  TextEditingController(text: '240');

  bool _isNightShift = false;
  bool _isActive = true;
  bool _isSaving = false;

  bool get isEdit => widget.shiftId != null;

  @override
  void dispose() {
    _shiftNameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _lateGraceController.dispose();
    _earlyLeaveController.dispose();
    _halfDayController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final provider = context.read<ShiftProvider>();
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

    final shift = ShiftModel(
      id: widget.shiftId ?? const Uuid().v4(),

      // TODO:
      // Replace with CompanyProvider.selectedCompany.id
      companyId: company.id,

      shiftName: _shiftNameController.text.trim(),

      startTime: _startTimeController.text.trim(),

      endTime: _endTimeController.text.trim(),

      lateGraceMinutes:
      int.parse(_lateGraceController.text),

      earlyLeaveGraceMinutes:
      int.parse(_earlyLeaveController.text),

      halfDayMinutes:
      int.parse(_halfDayController.text),

      isNightShift: _isNightShift,

      isActive: _isActive,

      createdAt: now,
      updatedAt: now,
    );

    bool success;

    if (isEdit) {
      success = await provider.updateShift(
        shift: shift,
      );
    } else {
      success = await provider.createShift(
        shift: shift,
      );
    }

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.error ?? 'Operation failed.',
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
              controller: _shiftNameController,
              decoration: const InputDecoration(
                labelText: 'Shift Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Shift name is required.';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _startTimeController,
              decoration: const InputDecoration(
                labelText: 'Start Time (09:00)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Start time is required.';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _endTimeController,
              decoration: const InputDecoration(
                labelText: 'End Time (18:00)',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'End time is required.';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _lateGraceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Late Grace (Minutes)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _earlyLeaveController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText:
                'Early Leave Grace (Minutes)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _halfDayController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Half Day Minutes',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text('Night Shift'),
              value: _isNightShift,
              onChanged: (value) {
                setState(() {
                  _isNightShift = value;
                });
              },
            ),

            SwitchListTile(
              title: const Text('Active'),
              value: _isActive,
              onChanged: (value) {
                setState(() {
                  _isActive = value;
                });
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                _isSaving ? null : _save,
                child: Text(
                  isEdit
                      ? 'Update Shift'
                      : 'Create Shift',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}