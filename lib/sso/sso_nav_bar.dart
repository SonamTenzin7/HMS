import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Navbar extends StatelessWidget {
  final TabController tabControls;

  Navbar({required this.tabControls});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabControls,
      indicatorColor: Colors.white,
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
          icon: Icon(FontAwesomeIcons.warehouse),
          text: 'Rooms',
        ),
        // Tab(
        //   icon: Icon(Icons.holiday_village),
        //   text: 'Add Hostel',
        // ),
      ],
    );
  }
}
