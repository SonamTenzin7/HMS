import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MaintenanceRequestPage extends StatefulWidget {
  final Function(String) onFormSubmit;

  MaintenanceRequestPage({Key? key, required this.onFormSubmit})
      : super(key: key);

  @override
  _MaintenanceRequestPageState createState() => _MaintenanceRequestPageState();
}

class _MaintenanceRequestPageState extends State<MaintenanceRequestPage> {
  XFile? _image;
  final picker = ImagePicker();

  TextEditingController hostelNameController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  void _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void submitMaintenanceRequest() {
    String hostelName = hostelNameController.text;
    String roomNumber = roomNumberController.text;
    String reason = reasonController.text;

    if (hostelName.isNotEmpty && roomNumber.isNotEmpty && reason.isNotEmpty) {
      // Process the maintenance request here
      String maintenanceRequestMessage =
          'Hostel Name: $hostelName\nRoom Number: $roomNumber\nReason: $reason';
      // You can save or send this message as needed

      // Call the callback function to pass the message to the parent widget
      widget.onFormSubmit(maintenanceRequestMessage);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maintenance request submitted.'),
        ),
      );

      // Clear form fields and image
      hostelNameController.clear();
      roomNumberController.clear();
      reasonController.clear();
      setState(() {
        _image = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Fill out the form for your maintenance:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Hostel Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: hostelNameController,
              decoration: InputDecoration(
                labelText: 'Hostel Name',
              ),
            ),
            Text(
              'Room Number:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: roomNumberController,
              decoration: InputDecoration(
                labelText: 'Room Number',
              ),
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
              controller: reasonController,
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
                    onPressed: submitMaintenanceRequest,
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
