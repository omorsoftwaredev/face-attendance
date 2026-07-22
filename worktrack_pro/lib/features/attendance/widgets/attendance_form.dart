import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../company/providers/company_provider.dart';
import '../../../core/models/attendance_model.dart';
import '../../employee/providers/employee_provider.dart';
import '../../shift/providers/shift_provider.dart';
import '../providers/attendance_provider.dart';
import '../utils/attendance_time_utils.dart';
import 'attendance_form/attendance_actions.dart';
import 'attendance_form/attendance_basic_info.dart';
import 'attendance_form/attendance_notes_section.dart';
import 'attendance_form/attendance_time_section.dart';

class AttendanceForm extends StatefulWidget {
  const AttendanceForm({
    super.key,
    this.attendanceId,
  });

  final String? attendanceId;

  @override
  State<AttendanceForm> createState() =>
      _AttendanceFormState();
}

class _AttendanceFormState
    extends State<AttendanceForm> {
  final _formKey = GlobalKey<FormState>();

  final _notesController =
  TextEditingController();

  String? _employeeId;
  String? _shiftId;

  DateTime _attendanceDate =
  DateTime.now();

  TimeOfDay? _checkInTime;
  TimeOfDay? _checkOutTime;

  bool _isSaving = false;

  bool get isEdit =>
      widget.attendanceId != null;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date =
    await AttendanceTimeUtils.pickDate(
      context: context,
      initialDate: _attendanceDate,
    );

    if (date != null) {
      setState(() {
        _attendanceDate = date;
      });
    }
  }

  Future<void> _pickCheckIn() async {
    final time =
    await AttendanceTimeUtils.pickTime(
      context: context,
      initialTime: _checkInTime,
    );

    if (time != null) {
      setState(() {
        _checkInTime = time;
      });
    }
  }

  Future<void> _pickCheckOut() async {
    final time =
    await AttendanceTimeUtils.pickTime(
      context: context,
      initialTime: _checkOutTime,
    );

    if (time != null) {
      setState(() {
        _checkOutTime = time;
      });
    }
  }
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_employeeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select an employee.',
          ),
        ),
      );
      return;
    }

    if (_shiftId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a shift.',
          ),
        ),
      );
      return;
    }

    if (_checkInTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select check in time.',
          ),
        ),
      );
      return;
    }

    if (_checkOutTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select check out time.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final provider =
    context.read<AttendanceProvider>();

    final companyProvider =
    context.read<CompanyProvider>();

    final company =
        companyProvider.selectedCompany;

    if (company == null) {
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a company.',
          ),
        ),
      );
      return;
    }

    final checkIn =
    AttendanceTimeUtils.combineDateAndTime(
      date: _attendanceDate,
      time: _checkInTime!,
    );

    final checkOut =
    AttendanceTimeUtils.combineDateAndTime(
      date: _attendanceDate,
      time: _checkOutTime!,
    );

    final workedMinutes =
        checkOut.difference(checkIn).inMinutes;

    final now = DateTime.now();

    final attendance = AttendanceModel(
      id: widget.attendanceId ??
          const Uuid().v4(),

      companyId: company.id,

      employeeId: _employeeId!,

      shiftId: _shiftId,

      attendanceDate: _attendanceDate,

      checkInTime: checkIn,

      checkOutTime: checkOut,

      checkInLatitude: null,
      checkInLongitude: null,

      checkOutLatitude: null,
      checkOutLongitude: null,

      workedMinutes:
      workedMinutes < 0 ? 0 : workedMinutes,

      lateMinutes: 0,

      earlyLeaveMinutes: 0,

      overtimeMinutes: 0,

      attendanceStatus: 'Present',

      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),

      createdAt: now,
      updatedAt: now,
    );

    bool success;

    if (isEdit) {
      success = await provider.updateAttendance(
        attendance: attendance,
      );
    } else {
      success = await provider.createAttendance(
        attendance: attendance,
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
            provider.error ??
                'Failed to save attendance.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeeProvider =
    context.watch<EmployeeProvider>();

    final shiftProvider =
    context.watch<ShiftProvider>();

    final employeeItems =
    employeeProvider.employees
        .map(
          (employee) =>
          DropdownMenuItem<String>(
            value: employee.id,
            child: Text(
              employee.fullName,
            ),
          ),
    )
        .toList();

    final shiftItems =
    shiftProvider.shifts
        .map(
          (shift) =>
          DropdownMenuItem<String>(
            value: shift.id,
            child: Text(
              shift.shiftName,
            ),
          ),
    )
        .toList();
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AttendanceBasicInfo(
            selectedEmployeeId: _employeeId,
            selectedShiftId: _shiftId,
            attendanceDate: _attendanceDate,
            employeeItems: employeeItems,
            shiftItems: shiftItems,
            onEmployeeChanged: (value) {
              setState(() {
                _employeeId = value;
              });
            },
            onShiftChanged: (value) {
              setState(() {
                _shiftId = value;
              });
            },
            onSelectDate: _pickDate,
          ),

          const SizedBox(height: 16),

          AttendanceTimeSection(
            checkInTime: _checkInTime,
            checkOutTime: _checkOutTime,
            onSelectCheckInTime: _pickCheckIn,
            onSelectCheckOutTime: _pickCheckOut,
          ),

          const SizedBox(height: 16),

          AttendanceNotesSection(
            notesController: _notesController,
          ),

          const SizedBox(height: 24),

          AttendanceActions(
            isLoading: _isSaving,
            isEdit: isEdit,
            onSave: _save,
            onCancel: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}