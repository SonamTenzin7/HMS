import 'package:flutter/material.dart';
import 'package:studentlogin/add_hostel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddHostel(),
    );
  }
}