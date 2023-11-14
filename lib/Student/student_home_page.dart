import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'student_menu.dart';
import 'student_hostel.dart';
import 'student_maintenance.dart';

class StudentHomePage extends StatefulWidget {
  final String studentId;

  const StudentHomePage({Key? key, required this.studentId});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String maintenanceRequestMessage = '';

  void updateMaintenanceRequestMessage(String message) {
    setState(() {
      maintenanceRequestMessage = message;
    });
  }

  void deleteMessage() {
    setState(() {
      maintenanceRequestMessage = '';
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isCardVisible = true;
  bool isDarkThemeEnabled = false;

  // Method to navigate to the "Maintenance Request" tab
  void navigateToMaintenanceTab() {
    _tabController.animateTo(2); // Index 2 corresponds to the "Maintenance Request" tab
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkThemeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(FontAwesomeIcons.bars),
              ),
              Tab(
                icon: Icon(Icons.hotel),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.wrench),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // Your content for the "Menu" tab
            StudentMenu(studentId: widget.studentId, onMaintenanceRequestTap: navigateToMaintenanceTab),

            // Your content for the "House" tab
            StudentHostel(studentId: widget.studentId),

            // Your content for the "Wrench" tab
            StudentMaintenance(studentId: widget.studentId),
          ],
        ),
      ),
    );
  }
}
