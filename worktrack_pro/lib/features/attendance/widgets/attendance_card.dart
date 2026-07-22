import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/models/attendance_model.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.attendance,
    required this.onEdit,
    required this.onDelete,
  });

  final AttendanceModel attendance;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  Color _statusColor(BuildContext context){
    switch(attendance.attendanceStatus.toLowerCase()){
      case 'present': return Colors.green;
      case 'late': return Colors.orange;
      case 'absent': return Colors.red;
      default: return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context){
    final theme=Theme.of(context);
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal:16,vertical:6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: const Icon(Icons.fact_check),
        ),
        title: Text(DateFormat('dd MMM yyyy').format(attendance.attendanceDate),style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top:6),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,children:[
            Chip(
              visualDensity: VisualDensity.compact,
              label: Text(attendance.attendanceStatus),
              backgroundColor: _statusColor(context).withOpacity(.15),
            ),
            Text('Check In : ${_fmt(attendance.checkInTime)}'),
            Text('Check Out : ${_fmt(attendance.checkOutTime)}'),
            const SizedBox(height:6),
            Wrap(spacing:6,runSpacing:6,children:[
              Chip(label: Text('Work ${attendance.workedMinutes}m')),
              Chip(label: Text('Late ${attendance.lateMinutes}m')),
              Chip(label: Text('OT ${attendance.overtimeMinutes}m')),
            ])
          ]),
        ),
        trailing: PopupMenuButton<String>(
          onSelected:(v){if(v=='edit'){onEdit();}else{onDelete();}},
          itemBuilder:(_)=>const[
            PopupMenuItem(value:'edit',child:Text('Edit')),
            PopupMenuItem(value:'delete',child:Text('Delete')),
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime? d)=>d==null?'-':DateFormat('hh:mm a').format(d);
}
