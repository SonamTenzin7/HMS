import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentlogin/admin/admin_hostel_add.dart';
import 'package:studentlogin/student/login.dart';

class MenuContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 30),
        Hero(
          tag: 'admin-icon',
          child: Icon(
            Icons.person,
            size: 60,
          ),
        ),
        Text(
          'Admin',
          style: GoogleFonts.raleway(
            fontSize: 24,
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
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: 400,
            height: 100,
            child: Card(
              elevation: 8,
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Icon(
                    Icons.holiday_village,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Add Hostel',
                    style:
                        GoogleFonts.raleway(fontSize: 20, color: Colors.white),
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
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: 400,
            height: 100,
            child: Card(
              elevation: 8,
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Icon(
                    Icons.transfer_within_a_station,
                    size: 40,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Request Room Change',
                    style:
                        GoogleFonts.raleway(fontSize: 20, color: Colors.white),
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
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: 400,
            height: 50,
            child: Card(
              elevation: 8,
              color: Colors.grey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Log Out',
                      style: GoogleFonts.raleway(
                          fontSize: 18, color: Colors.black),
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
