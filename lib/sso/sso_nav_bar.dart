import 'package:flutter/material.dart';

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
          icon: Icon(Icons.menu),
        ),
        Tab(
          icon: Icon(Icons.apartment),
        ),
        Tab(
          icon: Icon(Icons.hotel),
        ),
      ],
    );
  }
}
