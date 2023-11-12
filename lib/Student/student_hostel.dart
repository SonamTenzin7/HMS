import 'package:flutter/material.dart';
import '../db/database_operations.dart';
import '../models/student.dart';

class StudentHostel extends StatefulWidget {
  final studentId;

  const StudentHostel({required this.studentId});

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
    // Fetch student room details and room members when the widget is initialized
    fetchRoomDetails();
  }

  void fetchRoomDetails() async {
  try {
    // Assuming you have a method getRoomDetailsByStudent in your DatabaseOperations class
    final roomDetails = await adm.getRoomDetailsByStudent(widget.studentId);

    setState(() {
      hostelName = roomDetails.hname ?? '';
      roomNumber = roomDetails.roomno.toString();
    });

    // Fetch students in the room
    final studentsInRoom = await adm.retrieveRoomDetail(roomDetails.id!);

    print(roomDetails.id ); // Add this line to print the result

    setState(() {
      roomMembers = studentsInRoom;
    });
  } catch (error) {
    print('Error fetching room details: $error');
    // Handle error as needed
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Visibility(
        child: Card(
          margin: EdgeInsets.all(16.0),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                RoomDetailsRow(
                  title: 'Hostel Name',
                  value: hostelName,
                ),
                RoomDetailsRow(
                  title: 'Room Number',
                  value: roomNumber,
                ),
                Divider(
                  height: 30,
                  thickness: 1,
                ),
                Text(
                  'Room Members',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text('Name'),
                        ),
                        TableCell(
                          child: Text('Department'),
                        ),
                        TableCell(
                          child: Text('Year'),
                        ),
                      ],
                    ),
                    for (var student in roomMembers)
                      TableRow(
                        children: [
                          TableCell(
                            child: Text('${student.fname} ${student.mname} ${student.lname}'),
                          ),
                          TableCell(
                            child: Text(student.dept),
                          ),
                          TableCell(
                            child: Text(student.year),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoomDetailsRow extends StatelessWidget {
  final String title;
  final String value;

  RoomDetailsRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
