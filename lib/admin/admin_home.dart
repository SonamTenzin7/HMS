import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdmHome extends StatefulWidget {
  @override
  _AdmHomeState createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
  Future<List<Map<String, String>>>? hostelData; // Change the type to nullable

  @override
  void initState() {
    super.initState();
    hostelData = fetchDataFromAPI();
  }

  Future<List<Map<String, String>>> fetchDataFromAPI() async {
    final Uri url = Uri.parse('http://10.2.28.201:3000/api/v1/hostels');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Map<String, String>> data = [];
      for (final entry in jsonData) {
        final Map<String, dynamic> hostel = entry as Map<String, dynamic>;
        final String name = hostel['name'];
        final String gender = hostel['gender'];
        data.add({'name': name, 'gender': gender});
      }
      return data;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, String>>>(
      future: hostelData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data available.'));
        } else {
          List<Map<String, String>> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final hostel = data[index];
              return Card(
                child: ListTile(
                  title: Text("Name: ${hostel['name']}"),
                  subtitle: Text("Gender: ${hostel['gender']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Add your edit action here
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
