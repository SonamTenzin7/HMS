import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:studentlogin/models/hostel.dart';

class AdmHome extends StatefulWidget {
  @override
  _AdmHomeState createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
  Future<List<Hostel>>? hostelData; // Change the type to nullable

  @override
  void initState() {
    super.initState();
    hostelData = fetchData();
  }

  Future<List<Hostel>> fetchData() async {
    final Uri url = Uri.parse('http://10.2.28.201:3000/api/allhostels');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Hostel> data = jsonData
          .map((entry) => Hostel.fromJson(entry as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
      return FutureBuilder<List<Hostel>>(
        future: hostelData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data available.'));
          } else {
            List<Hostel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final hostel = data[index];
                return Card(
                  child: ListTile(
                    title: Text("Name: ${hostel.name}"),
                    subtitle: Text("Gender: ${hostel.gender}"),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Your edit logic here
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      );
  }
}
