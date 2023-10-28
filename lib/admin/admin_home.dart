import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AdmHome extends StatefulWidget {
  @override
  _AdmHomeState createState() => _AdmHomeState();
}

class _AdmHomeState extends State<AdmHome> {
  List<Map<String, String>> hostelData = []; // List to store hostel name and gender

  @override
  void initState() {
    super.initState();
    fetchDataFromDatabase();
  }

  // Function to fetch data from the PostgreSQL server
  Future<void> fetchDataFromDatabase() async {
    final conn = PostgreSQLConnection(
      'ep-delicate-poetry-06982532.ap-southeast-1.aws.neon.tech',
      5432,
      'neondb',
      username: 'ugy420',
      password: 'EDrb8Re2IWux',
    );

    try {
      await conn.open();
      final results = await conn.query('SELECT name, gender FROM hostel');
      for (final row in results) {
        final name = row[0] as String;
        final gender = row[1] as String;
        hostelData.add({'name': name, 'gender': gender});
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      await conn.close();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hostelData.length,
      itemBuilder: (context, index) {
        final hostel = hostelData[index];
        return Card(
          child: ListTile(
            title: Text("${hostelData[index]['name']}"),
            subtitle: Text("${hostel['gender']}"),
          ),
        );
      },
    );
  }
}
