import 'package:flutter/material.dart';
import 'package:studentlogin/models/hostel.dart';
import 'database_operations.dart';

class EditHostel extends StatefulWidget {
  final Hostel hostel;

  EditHostel({required this.hostel});

  @override
  _EditHostelState createState() => _EditHostelState();
}


class _EditHostelState extends State<EditHostel> {
  String? selectedValue;
  late TextEditingController hostelNameController;
  AdminData adminData = AdminData();

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the existing hostel name
    hostelNameController = TextEditingController(text: widget.hostel.name);

    // Initialize the selectedValue with the existing hostel type
    selectedValue = widget.hostel.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Hostel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              'Edit Hostel Name',
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
                // Update the hostel data in your database with the new values
                await adminData.updateHostel(
                  widget.hostel.id!,
                  hostelNameController.text,
                  selectedValue!,
                  context
                );
                Navigator.of(context).pop();
                Navigator.of(context).pop(true); // Pass true to indicate a successful update
              },
              child: Text('Edit Hostel'),
            ),
          ],
        ),
      ),
    );
  }
}
