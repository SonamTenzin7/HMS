import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 4,
        vsync: this); // Four tabs for menu, house, wrench, and notifications
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isCardVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white, // Color of the underline
          tabs: <Widget>[
            Tab(
              icon: Icon(FontAwesomeIcons.bars),
              text: 'Menu',
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.house),
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
          Container(
            child: Center(
              child: Text("Wrench Content"),
            ),
          ),
          // Your content for the "House" tab
          Visibility(
            visible: isCardVisible,
            child: Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Room Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text('Hostel Name:')),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Your Hostel Name'),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(child: Text('Room Number:')),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Your Room Number'),
                              ),
                            ),
                          ],
                        ),
                        // Add more rows for room details as needed
                      ],
                      border: TableBorder.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                    Divider(
                      height: 30,
                      thickness: 5,
                    ),
                    Text(
                      'Room Members',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.user),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Member 1'),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(FontAwesomeIcons.user),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Member 2'),
                              ),
                            ),
                          ],
                        ),
                        // Add more rows for room members as needed
                      ],
                      border: TableBorder.all(
                        color: Colors.black,
                        width: 2.0,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Your content for the "Wrench" tab
          Container(
            child: Center(
              child: Text("Wrench Content"),
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
    );
  }
}
