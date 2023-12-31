import 'package:flutter/material.dart';
import '../models/room.dart';
import '../db/database_operations.dart';
import 'sso_room_detail.dart';
import 'package:google_fonts/google_fonts.dart';  // Import Google Fonts

class Rooms extends StatefulWidget {
  @override
  _StateRooms createState() => _StateRooms();
}

class _StateRooms extends State<Rooms> {
  late Future<List<Room>> rooms;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshRooms();
  }

  _refreshRooms() async {
    final adm = AdminData();
    rooms = adm.retrieveAllotee();
  }

  List<Room> _filterRooms(List<Room> rooms, String query) {
    return rooms
        .where((room) =>
            room.roomno.toString().contains(query) ||
            room.hname?.contains(query) == true ||
            room.sid?.contains(query) == true ||
            room.fname?.contains(query) == true ||
            room.mname?.contains(query) == true ||
            room.lname?.contains(query) == true ||
            room.dept?.contains(query) == true ||
            room.year?.contains(query) == true ||
            room.gender?.contains(query) == true)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter room number, name, ID, etc.',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Room>>(
              future: rooms,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No rooms available.'));
                } else {
                  List<Room> filteredRooms =
                      _filterRooms(snapshot.data!, searchController.text);
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                              'Hostel',
                              style: GoogleFonts.raleway(),  // Apply Google Fonts
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Student ID',
                              style: GoogleFonts.raleway(),  // Apply Google Fonts
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Name',
                              style: GoogleFonts.raleway(),  // Apply Google Fonts
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Deptartment',
                              style: GoogleFonts.raleway(),  // Apply Google Fonts
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Year',
                              style: GoogleFonts.raleway(),  // Apply Google Fonts
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Gender',
                              style: GoogleFonts.raleway(),  // Apply Google Fonts
                            ),
                          ),
                        ],
                        rows: filteredRooms.map((student) {
                          return DataRow(
                            cells: [
                              DataCell(InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RoomDetailsScreen(
                                        room: student,
                                        hostelName: student.hname!,
                                      ),
                                    ),
                                  );
                                  print('Tapped on room ${student.roomno}');
                                },
                                child: Text(
                                  '${student.roomno}',
                                  style: GoogleFonts.raleway(),  // Apply Google Fonts
                                ),
                              )),
                              DataCell(InkWell(
                                onTap: () {
                                  print('Tapped on hostel ${student.hname}');
                                },
                                child: Text(
                                  '${student.hname}',
                                  style: GoogleFonts.raleway(),  // Apply Google Fonts
                                ),
                              )),
                              DataCell(InkWell(
                                onTap: () {
                                  print('Tapped on student ID ${student.sid ?? ""}');
                                },
                                child: Text(
                                  '${student.sid ?? ""}',
                                  style: GoogleFonts.raleway(),  // Apply Google Fonts
                                ),
                              )),
                              DataCell(InkWell(
                                onTap: () {
                                  print('Tapped on name ${student.fname ?? ""} ${student.mname ?? ""} ${student.lname ?? ""}');
                                },
                                child: Text(
                                  '${student.fname ?? ""} ${student.mname ?? ""} ${student.lname ?? ""}',
                                  style: GoogleFonts.raleway(),  // Apply Google Fonts
                                ),
                              )),
                              DataCell(InkWell(
                                onTap: () {
                                  // Handle tap on the row
                                  print('Tapped on department ${student.dept ?? ""}');
                                },
                                child: Text(
                                  '${student.dept ?? ""}',
                                  style: GoogleFonts.raleway(),  // Apply Google Fonts
                                ),
                              )),
                              DataCell(InkWell(
                                onTap: () {
                                  // Handle tap on the row
                                  print('Tapped on year ${student.year ?? ""}');
                                },
                                child: Text(
                                  '${student.year ?? ""}',
                                  style: GoogleFonts.raleway(),  // Apply Google Fonts
                                ),
                              )),
                              DataCell(InkWell(
                                onTap: () {
                                  // Handle tap on the row
                                  print('Tapped on gender ${student.gender ?? ""}');
                                },
                                child: Text(
                                  '${student.gender ?? ""}',
                                  style: GoogleFonts.raleway(),  // Apply Google Fonts
                                ),
                              )),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
