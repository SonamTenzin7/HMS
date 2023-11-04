import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_db.dart';


class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  
  final TextEditingController hostelNameController = TextEditingController();
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
              controller: hostelNameController,
              decoration: InputDecoration(
                hintText: 'Room Number',
              ),
            ),
            
            ElevatedButton(
              onPressed: () async {
          
              },
              child: Text('Add Room'),
            ),
          ],
        ),
      ),
    );
  }
}
