import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_counsellor_add.dart';
import 'package:studentlogin/models/student.dart';
import 'package:studentlogin/models/hostel.dart';
import 'database_operations.dart';
import 'admin_counsellor_detail.dart';

class CounsellorTab extends StatefulWidget {
  @override
  _CounsellorTabState createState() => _CounsellorTabState();
}

class _CounsellorTabState extends State<CounsellorTab> {
  Future<List<Student>>? counselors;
  Future<List<Hostel>>? hostels;

  @override
  void initState() {
    super.initState();
    _loadCounsellors();
  }

  Future<void> _loadCounsellors() async {
    final admData = AdminData();
    final counsellorList = await admData.retrieveCounsellors();

    setState(() {
      counselors = Future.value(counsellorList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Block Counselors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
  child: FutureBuilder<List<Student>>(
    future: counselors,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data == null) {
        return Center(child: Text('No counselors available.'));
      } else {
        List<Student> data = snapshot.data!;
        return Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                final counselor = data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CounDetail(counsellor: counselor),
                      ),
                    ).then((result) {
                      if (result == true) {
                        _loadCounsellors();
                      }
                    });
                  },
                  child: ListTile(
                    title: Text("${counselor.fname} ${counselor.mname} ${counselor.lname}"),
                    subtitle: Text("${counselor.id.toString()}"),
                  ),
                );
              },
            ),
          ],
        );
      }
    },
  ),
  ),
  Align(
    alignment: Alignment.bottomRight,
    child: FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddCounselor()),
        ).then((result) {
          if (result == true) {
            _loadCounsellors();
          }
        });
      },
      child: Icon(Icons.add),
    ),
  ),
  ],
  )
    );
  }
}
