import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../company/providers/company_provider.dart';
import '../providers/attendance_provider.dart';
import '../widgets/attendance_card.dart';
import 'attendance_form_page.dart';

class AttendanceListPage extends StatefulWidget {
  const AttendanceListPage({super.key});

  @override
  State<AttendanceListPage> createState() => _AttendanceListPageState();
}

class _AttendanceListPageState extends State<AttendanceListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final company = context.read<CompanyProvider>().selectedCompany;
      if (company != null) {
        context.read<AttendanceProvider>().loadAttendances(companyId: company.id);
      }
    });

    _searchController.addListener(() {
      context.read<AttendanceProvider>().search(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    final company = context.read<CompanyProvider>().selectedCompany;
    if (company == null) return;
    await context.read<AttendanceProvider>().refresh(companyId: company.id);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AttendanceProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Attendance'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceFormPage()));
          if (mounted) await _refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('Attendance'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SearchBar(controller: _searchController, hintText: 'Search attendance...', leading: const Icon(Icons.search)),
        ),
        Expanded(
          child: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: _refresh,
            child: provider.filteredAttendances.isEmpty
                ? ListView(children: const [SizedBox(height:180),Icon(Icons.fact_check_outlined,size:80),SizedBox(height:20),Center(child:Text('No Attendance Found'))])
                : ListView.builder(
                padding: const EdgeInsets.only(bottom: 90),
                itemCount: provider.filteredAttendances.length,
                itemBuilder: (context,index){
                  final attendance=provider.filteredAttendances[index];
                  return AttendanceCard(
                    attendance: attendance,
                    onEdit: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (_)=>AttendanceFormPage(attendanceId: attendance.id)));
                      if(mounted) await _refresh();
                    },
                    onDelete: () async {
                      final ok=await showDialog<bool>(context: context,builder:(_)=>AlertDialog(title: const Text('Delete Attendance'),content: const Text('Are you sure?'),actions:[TextButton(onPressed:()=>Navigator.pop(context,false),child:const Text('Cancel')),FilledButton(onPressed:()=>Navigator.pop(context,true),child:const Text('Delete'))]));
                      if(ok==true){
                        final success=await provider.deleteAttendance(attendance.id);
                        if(!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success?'Attendance deleted successfully.':provider.error??'Delete failed.')));
                      }
                    },
                  );
                }),
          ),
        )
      ]),
    );
  }
}
