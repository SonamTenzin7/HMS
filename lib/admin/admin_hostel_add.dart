import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_db.dart';


class AddHostel extends StatefulWidget {
  @override
  _AddHostelState createState() => _AddHostelState();
}

class _AddHostelState extends State<AddHostel> {
  String? selectedValue = 'M';
  final TextEditingController hostelNameController = TextEditingController();
  AdminData adminData = AdminData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Hostel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Enter Hostel Name',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            TextField(
              controller: hostelNameController,
              decoration: InputDecoration(
                hintText: 'Hostel Name',
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                    Text('Male'),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Female',
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                debugPrint('Button !');
                await adminData.insertHostel(hostelNameController.text, selectedValue!);
                Navigator.pop(context, true);
              },
              child: Text('Add Hostel'),
            ),
          ],
        ),
      ),
    );
  }
}
