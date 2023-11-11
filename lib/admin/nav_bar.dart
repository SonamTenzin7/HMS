import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTabBar extends StatelessWidget {
  final TabController tabController;

  CustomTabBar({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TabBar(
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: const Color.fromARGB(255, 16, 142, 245),
        ),
        tabs: <Widget>[
          Tab(
            icon: Icon(FontAwesomeIcons.bars),
            text: 'Menu',
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.house),
            text: 'Hostel',
          ),
          Tab(
            icon: Icon(FontAwesomeIcons.peopleGroup),
            text: 'Counsellor',
          ),
          Tab(
            icon: Icon(Icons.holiday_village),
            text: 'SSO',
          ),
        ],
      ),
    );
  }
}
