import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../models/student.dart';
import '../models/hostel.dart';
import '../db/database_operations.dart';

class AddCounselor extends StatefulWidget {
  @override
  AddCounselorState createState() => AddCounselorState();
}

class AddCounselorState extends State<AddCounselor> {
  String? selectedStudentId;
  String? selectedHostelName;
  int? selectedHostelId;

  final admData = AdminData();
  Future<List<Student>>? students;
  Future<List<Hostel>>? hostels;
  final GlobalKey<AutoCompleteTextFieldState<Student>> studentKey =
      GlobalKey();
  TextEditingController selectedStudentController = TextEditingController();
  TextEditingController selectedStudentIdController = TextEditingController();
  TextEditingController selectedStudentDeptController = TextEditingController();
  TextEditingController selectedStudentYearController = TextEditingController();
  TextEditingController selectedStudentGenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStudents();
    _loadHostels();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Counselor'),
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
                      labelText: 'Select Student',
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
                  return DropdownButtonFormField<String>(
                    value: selectedHostelName,
                    onChanged: (value) {
                      setState(() {
                        selectedHostelId = int.parse(value!);
                      });
                    },
                    items: hostelData.map((hostel) {
                      return DropdownMenuItem<String>(
                        value: hostel.id.toString(),
                        child: Text(hostel.name),
                      );
                    }).toList(),
                    hint: Text('Select Hostel'),
                  );
                }
              },
            ),
            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () async{
                bool suc = await admData.insertCounsellor(selectedHostelId!, selectedStudentId!, context);
                if(suc){
                  Navigator.pop(context,true);
                }
              },
              child: Text('Assign Counselor'),
            ),
          ],
        ),
      ),
    );
  }
}
