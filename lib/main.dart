import 'package:flutter/material.dart';
import 'package:studentlogin/addNoteFormPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentHomePage(),
    );
  }
}

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('View Room Details'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomDetailsPage()),
                );
              },
            ),
            ListTile(
              title: Text('View Room Inventory'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RoomInventoryPage()),
                );
              },
            ),
            ListTile(
              title: Text('Request Room Change'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RoomChangeRequestPage()),
                );
              },
            ),
            ListTile(
              title: Text('Request Maintenance'),
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
      body: Center(
        
      ),
    );
  }
}

class RoomDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Room Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 2, // Add elevation for a card-like appearance
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DataTable(
                      dataRowHeight: 50, // Adjust the row height as needed
                      headingRowColor:
                          MaterialStateProperty.all(Colors.grey[300]), // Header row color
                      columns: [
                        DataColumn(label: Text('Your Details')),
                        DataColumn(label: Text('Your Room Details')),
                      ],
                      rows: [], // Empty rows, no data for now
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomInventoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Inventory'),
      ),
      body: Center(
        child: Text('View your room inventory here.'),
      ),
    );
  }
}

class RoomChangeRequestPage extends StatefulWidget {
  @override
  _RoomChangeRequestPageState createState() => _RoomChangeRequestPageState();
}

class _RoomChangeRequestPageState extends State<RoomChangeRequestPage> {
  TextEditingController _reasonController = TextEditingController();
  String _presentHostel = 'Hostel A'; // Default present hostel
  String _newHostel = 'Hostel B'; // Default new hostel
  String _roomNumber = '101'; // Default room number
  bool isFormSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Room Change'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select Present Hostel:',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<String>(
              value: _presentHostel,
              onChanged: (String? newValue) {
                setState(() {
                  _presentHostel = newValue!;
                });
              },
              items: <String>[
                'Hostel A',
                'Hostel B',
                'Hostel C',
                'Hostel D',
                'Hostel E',
                'Hostel RK',
                'Hostel NK',
                'Lhawang'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              'Select New Hostel:',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<String>(
              value: _newHostel,
              onChanged: (String? newValue) {
                setState(() {
                  _newHostel = newValue!;
                });
              },
              items: <String>[
                'Hostel A',
                'Hostel B',
                'Hostel C',
                'Hostel D',
                'Hostel E',
                'Hostel RK',
                'Hostel NK',
                'Lhawang'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
              width: 50,
            ),
            Text(
              'Enter Room Number:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              onChanged: (value) {
                _roomNumber = value;
              },
              decoration: InputDecoration(
                hintText: 'Room Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Please provide a reason for your room change request:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _reasonController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your reason here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can access all the selected values here
                String reason = _reasonController.text;
                print('Room Change Requested with reason: $reason');
                print('Present Hostel: $_presentHostel');
                print('New Hostel: $_newHostel');
                print('Room Number: $_roomNumber');
                setState(() {
                  isFormSubmitted = true;
                });
              },
              child: Text('Submit Request'),
            ),
             
            Visibility(
              visible: isFormSubmitted,
              
              child: Card(
                elevation: 2,
                child: Padding(
                                   padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Submitted Room Change Request Details:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text('Reason: ${_reasonController.text}'), // Corrected line
                      Text('Present Hostel: $_presentHostel'),
                      Text('New Hostel: $_newHostel'),
                      Text('Room Number: $_roomNumber'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaintenanceRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Maintenance'),
      ),
     body: Stack(
  children: [
    Center(
      child: Text('Submit your maintenance request here.'),
    ),
    Positioned(
      bottom: 16.0, // Adjust the distance from the bottom as needed
      right: 16.0, // Adjust the distance from the right as needed
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddNotesFormPage()),
  );
          // Handle the action when the plus button is pressed
          // For example, you can show a dialog or navigate to another page
          // to add notes.
        },
        child: Icon(Icons.add),
      ),
    ),
  ],
),

    );
  }
}

