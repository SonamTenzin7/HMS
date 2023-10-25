import 'package:flutter/material.dart';
import 'package:studentlogin/admin/nav_bar.dart';

class test extends StatefulWidget{
  @override
  _testState createState() => _testState(); 
}

class _testState extends State<test>{
  late TabController _tabController;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomTabBar(tabController: _tabController),
        ),
      )
    );
  }
}