import 'package:flutter/material.dart';
import 'package:studentlogin/inventory_list_page.dart';
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
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.house,
                size: 25,
                color: Colors.black,
              ),
              title: const Text('Hostel'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RoomDetailsPage()),
                );
              },
            ),
            ListTile(
              leading: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FontAwesomeIcons.arrowUp,
                    color: Colors.green,
                    size: 15,
                  ),
                  Icon(
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
                    builder: (context) => const RoomChangeRequestPage(),
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
                    builder: (context) => const MaintenanceRequestPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Card(
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Room Details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Center(child: Text('Hostel Name:')),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Text('Your Hostel Name'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Center(child: Text('Room Number:')),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Text('Your Room Number'),
                        ),
                      ),
                    ],
                  ),
                  // Add more rows for room details as needed
                ],
                border: TableBorder.all(
                  color: Colors.black, // Border color
                  width: 2.0, // Border width
                  style: BorderStyle.solid, // Border style
                ),
              ),
              const Divider(
                height: 30,
                thickness: 5,
              ),
              const Text(
                'Room Members',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: const [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Icon(FontAwesomeIcons.user),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Text('Member 1'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Icon(FontAwesomeIcons.user),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: EdgeInsets.all(
                              8.0), // Add cell spacing here
                          child: Text('Member 2'),
                        ),
                      ),
                    ],
                  ),
                  // Add more rows for room members as needed
                ],
                border: TableBorder.all(
                  color: Colors.black,
                  width: 2.0,
                  style: BorderStyle.solid,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
