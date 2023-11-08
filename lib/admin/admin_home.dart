import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_hostel_add.dart';
import 'package:studentlogin/admin/admin_hostel_detail.dart';
import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/admin/database_operations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdmHome extends StatefulWidget {
  @override
  _AdmHomeState createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
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
    final data = await admData.retrieveHostels();

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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200), // Adjust the maximum width as needed
          child: FutureBuilder<List<Hostel>>(
            future: hostelData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('No hostels available.');
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
                            builder: (context) => HostelDetail(hostel: hostel),
                          ),
                        ).then((result) {
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHostel()),
          ).then((result) {
            if (result == true) {
              _loadHostels();
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
