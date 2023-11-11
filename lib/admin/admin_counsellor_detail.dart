import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/hostel.dart';
import '../db/database_operations.dart';

class CounDetail extends StatefulWidget {
  final Student counsellor;
  CounDetail({required this.counsellor});

  @override
  _CounDetailState createState() => _CounDetailState();
}

class _CounDetailState extends State<CounDetail> {
  Future<Hostel>? hostel;
  AdminData adm = AdminData();

  @override
  void initState() {
    super.initState();
    _loadHostel(widget.counsellor.hosId);
  }

  Future<void> _loadHostel(int? hosId) async {
    if (hosId != null) {
      Future<Hostel> hostel = adm.retrieveHostel(hosId);
      setState(() {
        this.hostel = hostel;
      });
    }
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this counselor?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async{
                final counsellorRemoved = await adm.deleteCounsellor(widget.counsellor.id);
                if (counsellorRemoved) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counselor Details'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Name',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '${widget.counsellor.fname} ${widget.counsellor.mname} ${widget.counsellor.lname}'),
                  ),
                  ListTile(
                    title: Text('Student ID'),
                    subtitle: Text(widget.counsellor.id),
                  ),
                  ListTile(
                    title: Text('Department'),
                    subtitle: Text(widget.counsellor.dept),
                  ),
                  ListTile(
                    title: Text('Year'),
                    subtitle: Text(widget.counsellor.year),
                  ),
                  ListTile(
                    title: Text('Gender'),
                    subtitle: Text(widget.counsellor.gender),
                  ),
                  FutureBuilder<Hostel>(
                    future: hostel,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListTile(
                          title: Text('Hostel'),
                          subtitle: Text('Loading...'),
                        );
                      } else if (snapshot.hasError) {
                        return ListTile(
                          title: Text('Hostel'),
                          subtitle: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        return ListTile(
                          title: Text('Hostel'),
                          subtitle: Text(snapshot.data?.name ?? 'N/A'),
                        );
                      } else {
                        return ListTile(
                          title: Text('Hostel'),
                          subtitle: Text('N/A'),
                        );
                      }
                    },
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      _confirmDelete(context);
                    },
                    child: Text('Remove'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
