import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentlogin/Student/login.dart';
import 'package:studentlogin/Student/maintenance_request_page.dart';
import 'package:studentlogin/Student/room_change_request_page.dart';
import 'student_menu.dart';
import 'student_hostel.dart';

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
        length: 4,
        vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isCardVisible = true;
  bool isDarkThemeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkThemeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Student Dashboard'),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(
                icon: Icon(FontAwesomeIcons.bars),
                text: 'Menu',
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.wrench),
                text: 'Maintenance',
              ),
              Tab(
                icon: Icon(Icons.notifications),
                text: 'Notifications',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            // Your content for the "Menu" tab
            StudentMenu(studentId: widget.studentId),

            // Your content for the "House" tab
            StudentHostel(studentId: widget.studentId),

            /// Your content for the "Wrench" tab
            Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Maintenance Request:\n$maintenanceRequestMessage",
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: deleteMessage,
                                  // Add your delete logic here
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Your content for the "Notifications" tab
            Container(
              child: Center(
                child: Text("Notifications Content"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
