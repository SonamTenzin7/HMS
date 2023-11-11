import 'package:flutter/material.dart';

class RoomChangeRequestPage extends StatefulWidget {
  const RoomChangeRequestPage({super.key});

  @override
  _RoomChangeRequestPageState createState() => _RoomChangeRequestPageState();
}

class _RoomChangeRequestPageState extends State<RoomChangeRequestPage> {
  final _formKey = GlobalKey<FormState>();
  final String _reason = '';
  String _newHostel = 'Hostel B';
  String _presentHostel = 'Hostel A';
  bool _isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Change Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Room Change Request',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: _presentHostel,
                    items: <String>[
                      'Hostel A',
                      'Hostel B',
                      'Hostel C',
                      'Hostel D',
                      'Hostel E',
                      // Add more hostels as needed
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _presentHostel = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Present Hostel',
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _newHostel,
                    items: <String>[
                      'Hostel A',
                      'Hostel B',
                      'Hostel C',
                      'Hostel D',
                      'Hostel E',
                      // Add more hostels as needed
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _newHostel = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'New Hostel',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Reason for room change',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a reason';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Set the submitted flag to true
                        setState(() {
                          _isSubmitted = true;
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  if (_isSubmitted) ...[
                    const SizedBox(height: 20),
                    const Text(
                      'Submitted Data:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Present Hostel: $_presentHostel'),
                    Text('New Hostel: $_newHostel'),
                    Text('Reason for room change: $_reason'),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
