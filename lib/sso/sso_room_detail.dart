import 'package:flutter/material.dart';
import 'package:studentlogin/models/room.dart';
import 'package:studentlogin/models/student.dart';
import 'package:studentlogin/db/database_operations.dart';
import 'package:google_fonts/google_fonts.dart'; 

class RoomDetailsScreen extends StatefulWidget {
  final Room room;
  final String hostelName;
  final AdminData adminData = AdminData();

  RoomDetailsScreen({required this.room, required this.hostelName});

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
    try {
      final List<Student> studentsData =
          await widget.adminData.retrieveRoomDetail(widget.room.id!);

      if (mounted) {
        setState(() {
          students = Future.value(studentsData);
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          students = Future.error(error);
        });
      }
    }
  }

  Future<void> _unallocateStudent(Student student) async {
    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Unallocation'),
          content: Text('Are you sure you want to unallocate ${student.fname} ${student.lname}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Unallocate'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final success = await widget.adminData.removeAllocation(student.id);
      if (success) {
        debugPrint('Deleted ${student.id}');
        _loadStudents(); // Refresh the list of students after successful deletion
      } else {
        debugPrint('Failed to delete');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hostel ${widget.hostelName} - ${widget.room.roomno}',
          style: GoogleFonts.raleway(),  
        ),
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
                      style: GoogleFonts.raleway(  
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DataTable(
                    columns: [
                      DataColumn(
                        label: Text(
                          'ID',
                          style: GoogleFonts.raleway(),  
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Name',
                          style: GoogleFonts.raleway(), 
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Department',
                          style: GoogleFonts.raleway(),  
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Actions',
                          style: GoogleFonts.raleway(),  
                        ),
                      ),
                    ],
                    rows: data.map((student) {
                      final fullName = '${student.fname} ${student.mname} ${student.lname}';
                      return DataRow(cells: [
                        DataCell(Text(
                          student.id,
                          style: GoogleFonts.raleway(),
                        )),
                        DataCell(Text(
                          fullName,
                          style: GoogleFonts.raleway(), 
                        )),
                        DataCell(Text(
                          student.dept,
                          style: GoogleFonts.raleway(), 
                        )),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {
                              _unallocateStudent(student);
                            },
                            child: Text('Unallocate'),
                          ),
                        ),
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
