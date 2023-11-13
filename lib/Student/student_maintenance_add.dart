import 'package:flutter/material.dart';
import 'package:studentlogin/db/database_operations.dart';
import '../models/room.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class MaintenanceRequestPage extends StatefulWidget {
  final studentId;
  const MaintenanceRequestPage({required this.studentId});

  @override
  _MaintenanceRequestPageState createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  TextEditingController hostelNameController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late Future<Room> details;
  final adm = AdminData();

  @override
  void initState() {
    super.initState();
    fetchRoom();
    setCurrentDate();
  }

  void fetchRoom() async {
    try {
      details = adm.getRoomByStudent(widget.studentId);
      Room data = await details;
      setState(() {
        hostelNameController.text = data.hname!;
        roomNumberController.text = data.roomno.toString();
      });
    } catch (error) {
      print('Error fetching student data: $error');
    }
  }

  void setCurrentDate() {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    dateController.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Text(
              'Hostel Name:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              enabled: false,
              controller: hostelNameController,
              decoration: InputDecoration(
              ),
            ),
            Text(
              'Room Number:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              enabled: false,
              controller: roomNumberController,
              decoration: InputDecoration(
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Please provide a reason for your Room maintenance request:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: reasonController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your reason here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Date:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              enabled: false,
              controller: dateController,
              decoration: InputDecoration(
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        Room data = await details; // Wait for the future to complete
                        await adm.insertMaintenance(
                          widget.studentId,
                          data.id!, // Access roomId from the obtained Room instance
                          reasonController.text,
                          dateController.text,
                          "Pending",
                          context,

                        );
                      debugPrint(data.id.toString());
                      } catch (error) {
                        print('Error obtaining Room data: $error');
                      }
                    },
                    child: Text('Submit'),
                  ),

                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
