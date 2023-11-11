import 'dart:async';
import 'package:flutter/material.dart';
import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/db/database_operations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentlogin/sso/sso_hostel_detail.dart';

class SsoHostel extends StatefulWidget {
  @override
  _SsoHostelState createState() => _SsoHostelState();
}

class _SsoHostelState extends State<SsoHostel> {
  Future<List<Hostel>>? hostelData;

  @override
  void initState() {
    super.initState();
    _loadHostels();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadHostels();
  }

  Future<void> _loadHostels() async {
    final admData = AdminData();
    final data = await admData.retrieveHostelnC();

    if (mounted) {
      setState(() {
        hostelData = Future.value(data);
      });
    }
  }

  @override
  void dispose() {
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
                Icon genderIcon;

                if (hostel.gender == 'Male') {
                  genderIcon = Icon(FontAwesomeIcons.mars, color: Colors.blue);
                } else if (hostel.gender == 'Female') {
                  genderIcon = Icon(FontAwesomeIcons.venus, color: Colors.pink); 
                } else {
                  genderIcon = Icon(FontAwesomeIcons.mars, color: Colors.grey);
                }


                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HostelinDetail(hostel: hostel),
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
                      title: Text("Hostel ${hostel.name}"),
                      subtitle: Row(
                        children: [
                          genderIcon,
                          Text("${hostel.gender}"),
                          Text("Block Counsellor: ${hostel.fname} ${hostel.mname} ${hostel.lname}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
