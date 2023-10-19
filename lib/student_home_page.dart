import 'package:flutter/material.dart';
import 'package:studentlogin/room_details_page.dart';
import 'package:studentlogin/room_change_request_page.dart';
import 'package:studentlogin/maintenance_request_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 149, 61),
              ),
              child: Column(
                children: [
                  Text(
                    'Student_Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Icon(
                    FontAwesomeIcons.graduationCap,
                    size: 70,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                FontAwesomeIcons.house,
                size: 25,
                color: Colors.black,
              ),
              title: const Text('Hostel'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomDetailsPage()),
                );
              },
            ),
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    FontAwesomeIcons.arrowUp,
                    color: Colors.green,
                    size: 15,
                  ),
                  const Icon(
                    FontAwesomeIcons.arrowDown,
                    color: Colors.red,
                    size: 15,
                  ),
                ],
              ),
              title: const Text('Request Room Change'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomChangeRequestPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Colors.black,
                size: 30,
              ),
              title: const Text('Request Maintenance'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MaintenanceRequestPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(),
    );
  }
}
