import 'package:flutter/material.dart';
import 'package:studentlogin/admin/nav_bar.dart';
import 'package:studentlogin/admin/menu.dart';
import 'package:studentlogin/admin/add_hostel.dart';

class tabContr extends StatefulWidget {
  @override
  _tabContr createState() => _tabContr();
}

class _tabContr extends State<tabContr> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // Adjust the length as needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomTabBar(tabController: _tabController),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[ 
          MenuContent(),
          
          AddHostel(),
          Center(
            child: Text('Placeholder Content'),
          ),
          Center(
            child: Text('Placeholder Content'),
          ),
        ],
      ),
    );
  }
}

