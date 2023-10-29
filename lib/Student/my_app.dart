import 'package:flutter/material.dart';
<<<<<<< HEAD:lib/my_app.dart
import 'package:studentlogin/admin/admin_control.dart';
import 'package:studentlogin/admin/admin_view_hostel.dart';
import 'package:studentlogin/hostel.dart';
import 'package:studentlogin/login.dart';
=======
import 'package:studentlogin/Student/login.dart';
>>>>>>> 325edb51d7a653b2a5069a3b0841aa6fca3d0720:lib/Student/my_app.dart

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}
