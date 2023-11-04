import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_db.dart';
import 'package:studentlogin/admin/admin_room_add.dart';
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
  List<Room> filteredRooms = [];
  AdminData adminData = AdminData();
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRooms();
  }

  Future<void> _loadRooms() async {
    final List<Room> roomsData = await adminData.retrieveRooms(widget.hostel.id!);
    setState(() {
      rooms = roomsData;
      filteredRooms = roomsData;
    });
  }

  void filterRooms(String searchText) {
    filteredRooms = rooms.where((room) {
      return room.roomno.toString().toLowerCase().contains(searchText.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                decoration: InputDecoration(hintText: 'Search'),
                onChanged: (text) {
                  setState(() {
                    filterRooms(text);
                  });
                },
              )
            : Text('Hostel ' + widget.hostel.name),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = false;
                      searchController.clear();
                      filteredRooms = rooms;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'add') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddRoom(hostelId: widget.hostel.id!),
                    ),
                  ).then((result){
                    if (result == true) {
                      _loadRooms();
                    }   
                  });
                } else if (value == 'delete') {
                  _showConfirmationDialog(context);
                }
              },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'add',
                  child: Text('Add Room'),
                ),
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Room Number')),
                    DataColumn(label: Text('Capacity')),
                  ],
                  rows: filteredRooms.map((room) {
                    return DataRow(
                      cells: [
                        DataCell(Text(room.roomno.toString())),
                        DataCell(Text(room.capacity.toString())),
                      ],
                    );
                  }).toList(),
                ),
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

                if (roomDeleted){
                   final deleted = await adminData.deleteHostel(widget.hostel.id, context);
                if (deleted) {

                  Navigator.of(context).pop();
                  Navigator.pop(context, true);
                } else {

                }
              }
            }
            )
          ],
        );
      },
    );
  }
}
