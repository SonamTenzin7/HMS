import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MaintenanceRequestPage(),
    );
  }
}

class MaintenanceRequestPage extends StatefulWidget {
  @override
  _MaintenanceRequestPageState createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  String maintenanceRequestMessage = '';

  void updateMaintenanceRequestMessage(String message) {
    setState(() {
      maintenanceRequestMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Maintenance'),
      ),
      body: Stack(
        children: [
          Center(
            child: Text(maintenanceRequestMessage),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNotesFormPage(
                          onFormSubmit: updateMaintenanceRequestMessage)),
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}

class AddNotesFormPage extends StatefulWidget {
  final Function(String) onFormSubmit;

  AddNotesFormPage({required this.onFormSubmit});

  @override
  _AddNotesFormPageState createState() => _AddNotesFormPageState();
}

class _AddNotesFormPageState extends State<AddNotesFormPage> {
  XFile? _image;
  final picker = ImagePicker();
  List<bool> isCheckedList =
      List.filled(7, false); // Initialize checkbox states
  List<bool> missingItems = [
    false,
    false,
    false
  ]; // Initialize missing item checkboxes

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Fill out the form for your maintenance:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Text and Label for Form Fields
            Text(
              'Hostel Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Hostel Name'), // Added label
            ),

            Text(
              'Room Number:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              decoration:
                  InputDecoration(labelText: 'Room Number'), // Added label
            ),

            SizedBox(height: 20),

            // Image Upload
            Text(
              'Upload Image:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            if (_image != null)
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(_image!.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Text(
              'Please provide a reason for your Room maintenance request:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Enter your reason here...',
                border: OutlineInputBorder(),
              ),
            ),

            // Spacer to push buttons to the bottom
            Spacer(),

            // Align buttons to the bottom center
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      String message = 'Maintenance request submitted.';
                      widget.onFormSubmit(message);
                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 10), // Adjust spacing as needed

                  // Cancel Button
                  TextButton(
                    onPressed: () {
                      // Handle the cancel action, e.g., navigate back
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
