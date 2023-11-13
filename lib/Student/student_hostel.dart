import 'package:flutter/material.dart';
import '../db/database_operations.dart';
import '../models/student.dart';

class StudentHostel extends StatefulWidget {
  final studentId;

  const StudentHostel({required this.studentId});

  @override
  _StudentHostelState createState() => _StudentHostelState();
}

class _StudentHostelState extends State<StudentHostel> {
  late Future<Student> student;
  final adm = AdminData();
  String hostelName = '';
  String roomNumber = '';
  List<Student> roomMembers = [];

  @override
  void initState() {
    super.initState();
    fetchRoomDetails();
  }

  void fetchRoomDetails() async {
    try {
      final roomDetails = await adm.getRoomDetailsByStudent(widget.studentId);

      setState(() {
        hostelName = roomDetails.hname ?? 'Unassigned';
        roomNumber = roomDetails.roomno.toString();
      });

      final studentsInRoom = await adm.retrieveRoomDetail(roomDetails.id!);

      setState(() {
        roomMembers = studentsInRoom;
      });
    } catch (error) {
      setState(() {
        hostelName = 'Unassigned';
      });
      print('Error fetching room details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Hostel Name:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10), // Add spacing between text and value
                Text(
                  hostelName,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Room Number:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10), // Add spacing between text and value
                Text(
                  roomNumber,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Divider(
              height: 30,
              thickness: 1,
            ),
            Text(
              'Room Members',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            DataTable(
              columns: [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Year')),
              ],
              rows: roomMembers
                  .map((student) => DataRow(
                        cells: [
                          DataCell(Text('${student.fname} ${student.mname} ${student.lname}')),
                          DataCell(Text(student.dept)),
                          DataCell(Text(student.year)),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
