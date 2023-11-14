import 'package:flutter/material.dart';
import '../models/maintenance.dart';
import '../db/database_operations.dart';
import 'student_maintenance_add.dart';
import 'package:intl/intl.dart';

class StudentMaintenance extends StatefulWidget {
  final studentId;

  const StudentMaintenance({required this.studentId});

  @override
  _StudentMaintenanceState createState() => _StudentMaintenanceState();
}

class _StudentMaintenanceState extends State<StudentMaintenance> {
  late Future<List<Maintenance>> maintenanceData;
  final adm = AdminData();

  @override
  void initState() {
    super.initState();
    maintenanceData = adm.getMaintenanceByStudent(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Maintenance>>(
        future: maintenanceData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No maintenance requests available.'));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Issue')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Action')),
                ],
                rows: snapshot.data!.map((maintenance) {
                  return DataRow(
                    cells: [
                      DataCell(Text('${maintenance.description}')),
                      DataCell(Text('${maintenance.status}')),
                      DataCell(Text(DateFormat('yyyy-MM-dd').format(maintenance.date))), 
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            try {
                              await adm.deleteMaintenance(maintenance.id);
                              setState(() {
                                maintenanceData = adm.getMaintenanceByStudent(widget.studentId);
                              });
                            } catch (error) {
                              print('Error deleting maintenance: $error');
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MaintenanceRequestPage(studentId: widget.studentId),

            )
          ).then((result){
            if(result){
               setState(() {
                maintenanceData = adm.getMaintenanceByStudent(widget.studentId);
              });
            }             
            });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
