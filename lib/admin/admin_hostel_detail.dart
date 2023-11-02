import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_db.dart';
import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/models/room.dart';

class HostelDetail extends StatefulWidget {
  final Hostel hostel;

  HostelDetail({required this.hostel});

  @override
  _HostelDetailState createState() => _HostelDetailState();
}

class _HostelDetailState extends State<HostelDetail> {
  List<Room> rooms = [];
  AdminData adminData = AdminData();

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    final List<Room> roomsData = await adminData.retrieveRooms(widget.hostel.id!);
    setState(() {
      rooms = roomsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel ' + widget.hostel.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showConfirmationDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "List of Rooms:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final room = rooms[index]; // Use 'room' instead of 'rooms'
                  return ListTile(
                    title: Text("Room Number: ${room.roomno}"), // Use 'room.roomid'
                    subtitle: Text("Capacity: ${room.capacity}"), // Use 'room.capacity'
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete Hostel ${widget.hostel.name}? This action is irreversible.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                final roomDeleted = await adminData.deleteRooms(widget.hostel.id, context);

                if(roomDeleted){
                   final deleted = await adminData.deleteHostel(widget.hostel.id, context);
                if (deleted) {
                  // Only pop the dialog and navigate back to the previous screen
                  Navigator.of(context).pop();
                  Navigator.pop(context, true);
                } else {
                  // Handle deletion failure if needed
                }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
