import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddHostel extends StatefulWidget {
  @override
  _AddHostelState createState() => _AddHostelState();
}

class _AddHostelState extends State<AddHostel> {
  String? selectedValue = 'M';
  final TextEditingController hostelNameController = TextEditingController();

  Future<void> insertHostel() async {
    final String name = hostelNameController.text;
    final String gender = selectedValue!;

    final String apiUrl = 'http://10.2.28.201:3000/api/addhostel'; // Replace with your API URL

    // Create a Map with your data and convert it to JSON
    final Map<String, dynamic> data = {
      'name': name,
      'gender': gender,
    };

    final String jsonData = jsonEncode(data);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json', // Set the content type to JSON
      },
      body: jsonData, // Send the JSON data as the request body
    );

    if (response.statusCode == 201) {
      debugPrint('Hostel added successfully');
    } else {
      debugPrint('Failed to add hostel. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            await insertHostel();
          },
          child: Text('Add Hostel'),
        ),
      ],
    );
  }
}
