import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../models/student.dart';
import '../models/hostel.dart';
import '../models/room.dart';
import '../db/database_operations.dart';

class Allocate extends StatefulWidget{
  _AllocateState createState() => _AllocateState();
}

class _AllocateState extends State<Allocate>{

  String? selectedStudentId;
  String? selectedHostelName;
  int? selectedHostelId;
  int? selectedRoomId;
  int? selectedRoomNo;
  final admData = AdminData();
  final GlobalKey<AutoCompleteTextFieldState<Student>> studentKey = GlobalKey();

  TextEditingController selectedStudentController = TextEditingController();
  TextEditingController selectedStudentIdController = TextEditingController();
  TextEditingController selectedStudentDeptController = TextEditingController();
  TextEditingController selectedStudentYearController = TextEditingController();
  TextEditingController selectedStudentGenController = TextEditingController();

  Future<List<Student>>? students;
  Future<List<Hostel>>? hostels;
  Future<List<Room>>? rooms;

  @override
  void initState() {
    super.initState();
    _loadStudents();
    _loadHostels();
    _loadRooms();
  }

  Future<void> _loadStudents() async {
    final studentlist = await admData.retrieveStudents();
    setState(() {
      students = Future.value(studentlist);
    });
  }

  Future<void> _loadHostels() async {
    final data = await admData.retrieveHostels();
    if (mounted) {
      setState(() {
        hostels = Future.value(data);
      });
    }
  }

  Future<void> _loadRooms() async {
    final data = await admData.retrieveRooms();
    if (mounted) {
      setState(() {
        rooms = Future.value(data);
      });
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allocate Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<Student>>(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No students available.');
                } else {
                  List<Student> studentData = snapshot.data!;
                  return AutoCompleteTextField<Student>(
                    key: studentKey,
                    clearOnSubmit: true,
                    suggestions: studentData,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      labelText: 'Search Student',
                    ),
                    itemFilter: (item, query) {
                      return item.fname.toLowerCase().contains(query.toLowerCase()) ||
                            item.mname.toLowerCase().contains(query.toLowerCase()) ||
                            item.lname.toLowerCase().contains(query.toLowerCase()) ||
                            item.id.contains(query);
                    },
                    itemSorter: (a, b) {
                      return a.fname.compareTo(b.fname);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        selectedStudentId = item.id;
                        selectedStudentController.text = '${item.fname} ${item.mname} ${item.lname}';
                        selectedStudentIdController.text = item.id;
                        selectedStudentDeptController.text = item.dept;
                        selectedStudentYearController.text = item.year;
                        selectedStudentGenController.text = item.gender;
                      });
                    },
                    itemBuilder: (context, item) {
                      return ListTile(
                        title: Text(item.fname + ' ' + item.mname + ' ' + item.lname),
                        subtitle: Text(item.id.toString()),
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: 16),

            TextFormField(
              controller: selectedStudentController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: selectedStudentIdController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Student Id',
              ),
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: selectedStudentDeptController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Department',
              ),
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: selectedStudentYearController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Year',
              ),
            ),

            SizedBox(height: 16),

            TextFormField(
              controller: selectedStudentGenController,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Gender',
              ),
            ),

            SizedBox(height: 16),

            FutureBuilder<List<Hostel>>(
              future: hostels,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No hostels available.');
                } else {
                  List<Hostel> hostelData = snapshot.data!;

                  List<Hostel> filteredHostels = hostelData
                      .where((hostel) =>
                          selectedStudentGenController.text.toLowerCase() ==
                          'male' // Change 'male' to the value you want to compare
                              ? hostel.gender.toLowerCase() == 'male'
                              : hostel.gender.toLowerCase() == 'female')
                      .toList();

                  return DropdownButtonFormField<String>(
                    value: selectedHostelName,
                    onChanged: (value) {
                      setState(() {
                        selectedHostelId = int.parse(value!);
                      });
                    },
                    items: filteredHostels.map((hostel) {
                      return DropdownMenuItem<String>(
                        value: hostel.id.toString(),
                        child: Text("Hostel ${hostel.name}"),
                      );
                    }).toList(),
                    hint: Text('Select Hostel'),
                  );
                }
              },
            ),
            SizedBox(height: 16),

            FutureBuilder<List<Room>>(
              future: rooms,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No rooms available.');
                } else {
                  List<Room> roomData = snapshot.data!;

                  List<Room> filteredRooms = roomData
                      .where((room) => room.hid == selectedHostelId)
                      .toList();

                  return DropdownButtonFormField<int>(
                    value: selectedRoomId,
                    onChanged: (value) {
                      setState(() {
                        selectedRoomId = value;
                      });
                    },
                    items: filteredRooms.map((room) {
                      return DropdownMenuItem<int>(
                        value: room.id,
                        child: Text('Room ${room.roomno}'),
                      );
                    }).toList(),
                    hint: Text('Select Room'),
                  );
                }
              },
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async{
                final success = await admData.insertAllocation(selectedRoomId!, selectedStudentId!, context);
                if(success){
                  setState(() {
                    
                  });
                }
                debugPrint("${selectedRoomId} ${selectedRoomNo} ${selectedStudentId}");               
              },
              child: Text('Assign'),
            ),
          ],
        ),
      ),
    );
  }
}