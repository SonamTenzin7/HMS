import 'package:flutter/material.dart';
import 'package:studentlogin/models/hostel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HostelDetail extends StatelessWidget {
  final Hostel hostel;

  HostelDetail({required this.hostel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel ' + hostel.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete), // Icon for delete
            onPressed: () {
              deleteHostel(hostel.id, context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Name: ${hostel.name}"),
            Text("Gender: ${hostel.gender}"),
            // Add more details about the hostel here
          ],
        ),
      ),
    );
  }
  
  Future<void> deleteHostel(int? hostelId, context ) async {
    final Uri url = Uri.parse('http://10.2.28.201:3000/api/delhostel/$hostelId'); // Replace with your server URL and endpoint

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // Hostel deleted successfully, you can navigate back to the previous screen or perform any other desired action.
        Navigator.pop(context);
      } else {
        // Handle the case where the delete request was not successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete the hostel $hostelId'),
          ),
        );
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print('Error: $e');
    }
  }
}

