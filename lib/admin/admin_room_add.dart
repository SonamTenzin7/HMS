import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_db.dart';
import 'package:flutter/services.dart';

class AddRoom extends StatefulWidget {
  final int hostelId;
  AddRoom({required this.hostelId});

  @override
  _AddRoomState createState() => _AddRoomState();

}

class _AddRoomState extends State<AddRoom> {
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController capacityController = TextEditingController();
  AdminData adminData = AdminData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Enter Room Number',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            TextField(
              controller: roomNumberController,
              decoration: InputDecoration(
                hintText: 'Room Number',
              ),
              keyboardType: TextInputType.number, // Set the keyboard type to numeric
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Enter Capacity',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            TextField(
              controller: capacityController,
              decoration: InputDecoration(
                hintText: 'Capacity',
              ),
              keyboardType: TextInputType.number, // Set the keyboard type to numeric
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String roomNumber = roomNumberController.text;
                String capacity = capacityController.text;
                debugPrint(roomNumber + " hi " + capacity);
                
                if (roomNumber.isNotEmpty && capacity.isNotEmpty) {
                  // Call the function to add the room to the database
                  bool roomAdded = await adminData.insertRoom(int.parse(roomNumber), int.parse(capacity), widget.hostelId, context);
                  
                  if (roomAdded) {
                    Navigator.pop(context, true); // Return to the previous screen
                  } else {
                    // Handle room addition failure
                  }
                } else {
                  // Handle validation error (empty fields)
                }
              },
              child: Text('Add Room'),
            ),
          ],
        ),
      ),
    );
  }
}
