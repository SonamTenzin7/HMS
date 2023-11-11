import 'package:flutter/material.dart';
import 'package:studentlogin/admin/nav_bar.dart';
import 'package:studentlogin/admin/admin_menu.dart';
import 'package:studentlogin/admin/Maintence.dart';
import 'package:studentlogin/admin/admin_home.dart';
import 'admin_counsellor.dart';

class AdmTab extends StatefulWidget {
  @override
  _AdmTabState createState() => _AdmTabState();
}

class _AdmTabState extends State<AdmTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomTabBar(tabController: _tabController),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[ 
          MenuContent(),
          AdmHome(),
          CounsellorTab(),
          HomePageWidget(),
        ],
      ),
    );
  }
}

