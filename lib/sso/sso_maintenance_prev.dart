import 'package:flutter/material.dart';
import '../db/database_operations.dart';
import '../models/maintenance.dart';
import 'package:intl/intl.dart';

class SsoMaintenanceOld extends StatefulWidget {
  _SsoMaintenanceStateOld createState() => _SsoMaintenanceStateOld();
}

class _SsoMaintenanceStateOld extends State<SsoMaintenanceOld> {
  final AdminData adm = AdminData();

  late Future<List<Maintenance>> maintenanceRequests;

  @override
  void initState() {
    super.initState();
    maintenanceRequests = adm.retrieveMaintenanceRequestsOld();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accepted Maintenance Requests'),
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
                ],
                rows: maintenanceList
                    .map(
                      (maintenance) => DataRow(
                        cells: [
                          DataCell(Text('${maintenance.hostel}')),
                          DataCell(Text('${maintenance.roomno}')),
                          DataCell(Text('${maintenance.description}')),
                          DataCell(Text(DateFormat('yyyy-MM-dd').format(maintenance.date))),
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
