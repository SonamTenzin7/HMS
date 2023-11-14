import 'package:flutter/material.dart';
import '../db/database_operations.dart';
import '../models/maintenance.dart';
import 'package:intl/intl.dart';
import 'sso_maintenance_prev.dart';

class SsoMaintenance extends StatefulWidget {
  _SsoMaintenanceState createState() => _SsoMaintenanceState();
}

class _SsoMaintenanceState extends State<SsoMaintenance> {
  final AdminData adm = AdminData();

  late Future<List<Maintenance>> maintenanceRequests;

  @override
  void initState() {
    super.initState();
    maintenanceRequests = adm.retrieveMaintenanceRequests();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Requests'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SsoMaintenanceOld()),
              );              
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Maintenance>>(
        future: maintenanceRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No maintenance requests available.'));
          } else {
            List<Maintenance> maintenanceList = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Hostel')),
                  DataColumn(label: Text('Room Number')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: maintenanceList
                    .map(
                      (maintenance) => DataRow(
                        cells: [
                          DataCell(Text('${maintenance.hostel}')),
                          DataCell(Text('${maintenance.roomno}')),
                          DataCell(Text('${maintenance.description}')),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(maintenance.date))),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.check, color: Colors.green),
                                  onPressed: () {
                                    adm.acceptMaintenance(maintenance.id);
                                    setState(() {
                                      maintenanceRequests = adm.retrieveMaintenanceRequests();
                                    });
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    adm.rejectMaintenance(maintenance.id);
                                    setState(() {
                                      maintenanceRequests = adm.retrieveMaintenanceRequests();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
