import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:studentlogin/Student/block_details.dart';
import 'package:studentlogin/Student/login.dart';
import 'package:studentlogin/Student/maintenance_request_page.dart';
import 'package:studentlogin/Student/room_change_request_page.dart';

class BlockCounsellorHomePage extends StatefulWidget {
  const BlockCounsellorHomePage({Key? key}) : super(key: key);

  @override
  _BlockCounsellorHomePageState createState() =>
      _BlockCounsellorHomePageState();
}

class _BlockCounsellorHomePageState extends State<BlockCounsellorHomePage>
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
        vsync: this); // Four tabs for menu, house, wrench, and notifications
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool isCardVisible = true;
  bool isDarkTheemEnabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkTheemEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counsellor Dashboard'),
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
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Student Name',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Computer Science - Year 2',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaintenanceRequestPage(
                                  onFormSubmit: updateMaintenanceRequestMessage,
                                )),
                      );
                    },
                    child: CardItem(
                      icon: FontAwesomeIcons.wrench,
                      title: 'Maintenance Request',
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RoomChangeRequestPage()),
                      );
                    },
                    child: CardItem(
                      icon: Icons.transfer_within_a_station,
                      title: 'Request Room Change',
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlockDetailsPage()),
                      );
                    },
                    child: CardItem(
                      icon: Icons.house,
                      title: 'Block Details',
                    ),
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: CardItem(
                      icon: Icons.logout,
                      title: 'Log Out',
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text('Theme'),
                    trailing: Switch(
                      value: isDarkTheemEnabled,
                      onChanged: (value) {
                        // Add code here to toggle between dark and light themes
                        // You can use a state management solution like Provider or setState.
                        setState(() {
                          isDarkTheemEnabled = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Your content for the "House" tab
            Visibility(
              visible: isCardVisible,
              child: Card(
                margin: EdgeInsets.all(16.0),
                elevation: 4,
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
                      RoomDetailsRow(
                          title: 'Hostel Name', value: 'Your Hostel Name'),
                      RoomDetailsRow(
                          title: 'Room Number', value: 'Your Room Number'),
                      // Add more room details rows as needed
                      Divider(
                        height: 30,
                        thickness: 1,
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
                                child: Text('Name'),
                              ),
                              TableCell(
                                child: Text('Department'),
                              ),
                              TableCell(
                                child: Text('Year'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text('Student 1'),
                              ),
                              TableCell(
                                child: Text('Computer Science'),
                              ),
                              TableCell(
                                child: Text('Year 2'),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Text('Student 2'),
                              ),
                              TableCell(
                                child: Text('Electrical Engineering'),
                              ),
                              TableCell(
                                child: Text('Year 3'),
                              ),
                            ],
                          ),
                          // Add more room members as needed
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Your content for the "Wrench" tab
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
            NotificationsContent(),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;

  CardItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class HouseContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 4,
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
            RoomDetailsRow(
              title: 'Hostel Name',
              value: 'Your Hostel Name',
            ),
            RoomDetailsRow(
              title: 'Room Number',
              value: 'Your Room Number',
            ),
            // Add more room details rows as needed
            Divider(
              height: 30,
              thickness: 1,
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
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Name'),
                    ),
                    TableCell(
                      child: Text('Department'),
                    ),
                    TableCell(
                      child: Text('Year'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Student 1'),
                    ),
                    TableCell(
                      child: Text('Computer Science'),
                    ),
                    TableCell(
                      child: Text('Year 2'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Student 2'),
                    ),
                    TableCell(
                      child: Text('Electrical Engineering'),
                    ),
                    TableCell(
                      child: Text('Year 3'),
                    ),
                  ],
                ),
                // Add more room members as needed
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RoomDetailsRow extends StatelessWidget {
  final String title;
  final String value;

  RoomDetailsRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class MaintenanceContent extends StatelessWidget {
  final String maintenanceRequestMessage;

  MaintenanceContent(this.maintenanceRequestMessage);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (maintenanceRequestMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      'Maintenance Request Message',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      maintenanceRequestMessage,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class NotificationsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Notifications Content',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
