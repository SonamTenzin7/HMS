import 'package:flutter/material.dart';
import 'package:studentlogin/admin/admin_add_hostel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentlogin/student/login.dart';

class MenuContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30),
        Icon(
          Icons.person_2,
          size: 40,
        ),
        Text(
          'Admin',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(height: 60),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddHostel()), // Use 'AddHostel' widget
            );
          },
          child: Container(
            width: 400, // Set the width of the Card
            height: 100, // Set the height of the Card
            child: Card(
              color: Color.fromARGB(255, 156, 225, 255),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Icon(
                    Icons.holiday_village,
                    size: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Add Hostel',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            // Handle 'Request Room Change' logic here
          },
          child: Container(
            width: 400, // Set the width of the Card
            height: 100, // Set the height of the Card
            child: Card(
              color: Color.fromARGB(255, 156, 225, 255),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Image.asset(
                    'images/transfer.png',
                    height: 30,
                    width: 30,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Request Room Change',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()), // Use 'Login' widget
            );
          },
          child: Container(
            width: 400, // Set the width of the Card
            height: 50, // Set the height of the Card
            child: Card(
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'LogOut',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
