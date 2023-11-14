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
        buildDivider(),
        buildMenuItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddHostel()),
            );
          },
          icon: Icons.holiday_village,
          label: 'Add Hostel',
          color: Colors.blue,
        ),
        buildDivider(),
        buildMenuItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        child: Card(
          elevation: 0,
          color: color ?? Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Colors.white,
                ),
                SizedBox(width: 16),
                Text(
                  label,
                  style: GoogleFonts.raleway(fontSize: 20, color: Colors.white),
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
