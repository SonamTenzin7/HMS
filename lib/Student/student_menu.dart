import 'package:flutter/material.dart';
import 'package:studentlogin/Student/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../db/database_operations.dart';
import '../models/student.dart';

class StudentMenu extends StatefulWidget {
  final studentId;
  final VoidCallback? onMaintenanceRequestTap; // Define the callback

  const StudentMenu({
    required this.studentId,
    this.onMaintenanceRequestTap,
  });

  _StudentMenuState createState() => _StudentMenuState();
}

class _StudentMenuState extends State<StudentMenu> {
  late Future<Student> student;
  final adm = AdminData();
  String studentName = '';
  String department = '';
  String year = '';

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  void fetchStudentData() async {
    try {
      student = adm.getStudent(widget.studentId);

      Student studentData = await student;

      setState(() {
        studentName = '${studentData.fname} ${studentData.mname ?? ''} ${studentData.lname ?? ''}';
        department = studentData.dept;
        year = studentData.year;
      });
    } catch (error) {
      print('Error fetching student data: $error');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.blue,
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studentName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${widget.studentId}",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '$year $department',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
            },
            child: CardItem(
              icon: Icons.home,
              title: 'Hostel',
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              if (widget.onMaintenanceRequestTap != null) {
                widget.onMaintenanceRequestTap!(); // Call the callback to navigate to the "Maintenance Request" tab
              }
            },
            child: CardItem(
              icon: FontAwesomeIcons.wrench,
              title: 'Maintenance Request',
            ),
          ),

          SizedBox(height: 10),
          InkWell(
            onTap: () {
              // Add logic for Room Change Request
            },
            child: CardItem(
              icon: Icons.transfer_within_a_station,
              title: 'Request Room Change',
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
            child: CardItem(
              icon: Icons.logout,
              title: 'Log Out',
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}


class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;

  CardItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
