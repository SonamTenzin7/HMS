import 'package:flutter/material.dart';

import 'package:studentlogin/admin/admin_hostel_add.dart';
import 'package:studentlogin/admin/admin_hostel_detail.dart';
import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/admin/admin_db.dart';

class AdmHome extends StatefulWidget {
  @override
  _AdmHomeState createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
  Future<List<Hostel>>? hostelData; // Change the type to nullable

@override
  void initState() {
    super.initState();
    _loadHostels();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload data when the screen is active
    _loadHostels();
  }

  Future<void> _loadHostels() async {
  final admData = AdminData();
  final data = await admData.retrieveHostels();

  if (mounted) {
    setState(() {
      hostelData = Future.value(data);
    });
  }
  }
  
  @override
  void dispose() {
    // Cleanup resources or cancel any ongoing operations here.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Hostel>>(
        future: hostelData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No hostels available.'));
          } else {
            List<Hostel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final hostel = data[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HostelDetail(hostel: hostel),
                      ),
                    ).then((result) {
                      // Refresh the data when returning from HostelDetail
                      if (result == true) {
                        _loadHostels();
                      }
                    });
                  },
                  child: Card(
                    child: ListTile(
                      title: Text("Name: ${hostel.name}"),
                      subtitle: Text("Gender: ${hostel.gender}"),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHostel()), // Use 'AddHostel' widget
          ).then((result) {
            if (result == true) {
            _loadHostels(); // Reload the data if the addition was successful
        }
      });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
