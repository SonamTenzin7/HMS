import 'package:flutter/material.dart';
import 'package:studentlogin/db/database_operations.dart';
import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/models/room.dart';
import 'package:google_fonts/google_fonts.dart';  
import 'sso_room_detail.dart';

class HostelinDetail extends StatefulWidget {
  final Hostel hostel;

  HostelinDetail({required this.hostel});

  @override
  _HostelinDetailState createState() => _HostelinDetailState();
}

class _HostelinDetailState extends State<HostelinDetail> {
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
    final List<Room> roomsData = await adminData.retrieveRoomsByHostel(widget.hostel.id!);
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

  int calculateTotalCapacity() {
    return rooms.fold(0, (sum, room) => sum + room.capacity);
  }

  int calculateTotalOccupancy() {
    return rooms.fold(0, (sum, room) => sum + int.parse(room.occupancy!));
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
            : Text(
                'Hostel ' + widget.hostel.name,
                style: GoogleFonts.raleway(),  // Apply Google Fonts
              ),
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
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hostel Capacity: ${calculateTotalCapacity()}',
                style: GoogleFonts.raleway(  // Apply Google Fonts
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hostel Occupancy: ${calculateTotalOccupancy()}',
                style: GoogleFonts.raleway(  // Apply Google Fonts
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text(
                        'Room Number',
                        style: GoogleFonts.raleway(),  // Apply Google Fonts
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Capacity',
                        style: GoogleFonts.raleway(),  // Apply Google Fonts
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Occupancy',
                        style: GoogleFonts.raleway(),  // Apply Google Fonts
                      ),
                    ),
                  ],
                  rows: filteredRooms.map((room) {
                    return DataRow(
                      cells: [
                        DataCell(
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RoomDetailsScreen(
                                    room: room,
                                    hostelName: widget.hostel.name,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              room.roomno.toString(),
                              style: GoogleFonts.raleway(),  // Apply Google Fonts
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            room.capacity.toString(),
                            style: GoogleFonts.raleway(),  // Apply Google Fonts
                          ),
                        ),
                        DataCell(
                          Text(
                            room.occupancy.toString(),
                            style: GoogleFonts.raleway(),  // Apply Google Fonts
                          ),
                        ),
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
}
