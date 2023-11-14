import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:studentlogin/models/maintenance.dart';
import 'sso_allocate.dart';
import 'package:studentlogin/student/login.dart';
import 'sso_maintenance.dart';

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
          child: Row(
            children: [
              Icon(
                Icons.person,
                size: 75,
                color: Colors.orange,
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chimi Dem',
                    style: GoogleFonts.raleway(
                      fontSize: 24,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    'Student Service Officer',
                    style: GoogleFonts.raleway(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: 60),
        buildDivider(),
        buildMenuItem(
          onTap: () {},
          tabIndex: 1,
          icon: Icons.apartment,
          label: 'Hostel',
        ),
        buildDivider(),
        buildMenuItem(
          onTap: () {},
          tabIndex: 2,
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
          tabIndex: 0,
          icon: Icons.holiday_village,
          label: 'Allocate Room',
        ),
         buildDivider(),
        buildMenuItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SsoMaintenance()),
            );
          },
          tabIndex: 0,
          icon: Icons.settings,
          label: 'Maintenance Requests',
        ),
        buildDivider(),
        buildMenuItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          tabIndex: 0,
          icon: Icons.logout,
          label: 'Log Out',
        ),
        buildDivider(),
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
        onTap();
        tabController.animateTo(tabIndex!);
      },
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
