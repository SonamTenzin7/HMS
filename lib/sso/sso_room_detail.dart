import 'package:flutter/material.dart';
import 'package:studentlogin/models/room.dart';
import 'package:studentlogin/models/student.dart';
import 'package:studentlogin/db/database_operations.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Room room;
  final AdminData adminData = AdminData();

  RoomDetailsScreen({required this.room});

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  Future<List<Student>>? students;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    final List<Student> studentsData =
        await widget.adminData.retrieveRoomDetail(widget.room.id!);
    setState(() {
      students = Future.value(studentsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Details'),
      ),
      body: FutureBuilder<List<Student>>(
        future: students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No students available.'));
          } else {
            List<Student> data = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Student Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Department')),
                      DataColumn(label: Text('Year')),
                      DataColumn(label: Text('Gender')),
                    ],
                    rows: data.map((student) {
                      final fullName = '${student.fname} ${student.mname} ${student.lname}';
                      return DataRow(cells: [
                        DataCell(Text(student.id)),
                        DataCell(Text(fullName)),
                        DataCell(Text(student.dept)),
                        DataCell(Text(student.year)),
                        DataCell(Text(student.gender)),
                      ]);
                    }).toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
