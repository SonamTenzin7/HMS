import 'package:flutter/material.dart';

class viewHostel extends StatefulWidget {
  @override
  _viewHostelState createState() => _viewHostelState();
}

class _viewHostelState extends State<viewHostel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hostel Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
