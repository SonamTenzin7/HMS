import 'package:flutter/material.dart';
import 'package:studentlogin/login.dart';
import 'package:studentlogin/admin/tab_control.dart';

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
        primaryColor: Color(0xFF0028A8),
      ),
      home: tabContr(),
    );
  }
}
