import 'package:flutter/material.dart';

class BlockDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Block Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildBlockDetailsRow('Block', 'A'),
            buildBlockDetailsRow('Room Number', '101'),
            buildBlockDetailsRow('Room Type', 'Single'),
            buildBlockDetailsRow('Number of Occupants', '1'),
          ],
        ),
      ),
    );
  }

  Widget buildBlockDetailsRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$title:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8),
          Text('$value'),
        ],
      ),
    );
  }
}
