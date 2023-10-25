import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;

  CustomTabBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      indicatorColor: Colors.white,
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
    );
  }
}
