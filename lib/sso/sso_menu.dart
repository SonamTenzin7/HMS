import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sso_allocate.dart';
import 'package:studentlogin/student/login.dart';

class MenuContent extends StatelessWidget {
  final TabController tabController;

  MenuContent({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 30),
        Hero(
          tag: 'admin-icon',
          child: Icon(
            Icons.person,
            size: 40,
            color: const Color.fromARGB(255, 108, 107, 107),
          ),
        ),
        Text(
          'Student_Service_Officer_Name',
          style: GoogleFonts.raleway(
            fontSize: 24,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        SizedBox(height: 60),
        buildDivider(),
        buildMenuItem(
          onTap: () {},
          tabIndex: 1, // Set the tab index for the "Hostel" tab
          icon: Icons.apartment,
          label: 'Hostel',
        ),
        buildDivider(),
        buildMenuItem(
          onTap: () {

          },
          tabIndex: 2, // Set the tab index for the "Rooms" tab
          icon: Icons.hotel,
          label: 'Rooms',
        ),
        buildDivider(),
        buildMenuItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Allocate()),
            );
          },
          tabIndex: 2,
          icon: Icons.holiday_village,
          label: 'Allocate Room',
        ),
        buildDivider(),
        buildMenuItem(
          onTap: () {
          },
          tabIndex: 2,
          icon: Icons.transfer_within_a_station,
          label: 'Request Room Change',
        ),
        buildDivider(), // Add a divider
        buildMenuItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          tabIndex: 0, // Set the tab index for the "Menu" tab
          icon: Icons.logout,
          label: 'Log Out',
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget buildMenuItem({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    Color? color,
    required tabIndex,
  }) {
    return GestureDetector(
      onTap: () {
        onTap(); // Execute the provided onTap function
        tabController.animateTo(tabIndex!); // Change the tab index
      },
      child: Container(
        width: double.infinity,
        height: 55,
        child: Card(
          elevation: 0, // Remove elevation
          color: color ?? Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                SizedBox(width: 16),
                Text(
                  label,
                  style: GoogleFonts.raleway(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }
}
