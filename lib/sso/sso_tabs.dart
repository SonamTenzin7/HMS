import 'package:flutter/material.dart';
import 'package:studentlogin/sso/sso_menu.dart';
import 'sso_rooms.dart';
import 'sso_hostel.dart';
import 'package:studentlogin/sso/sso_nav_bar.dart';

class SsoTab extends StatefulWidget {
  @override
  _SsoTabState createState() => _SsoTabState();
}

class _SsoTabState extends State<SsoTab> with SingleTickerProviderStateMixin {
  late TabController _tabControls;

  @override
  void initState() {
    super.initState();
    _tabControls = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          elevation: 4, // Adjust the elevation as needed
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Navbar(tabControls: _tabControls),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabControls,
        children: <Widget>[
          MenuContent(tabController: _tabControls),
          SsoHostel(),
          Rooms(),
        ],
      ),
    );
  }
}
