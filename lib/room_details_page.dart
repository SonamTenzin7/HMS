import 'package:flutter/material.dart';

class RoomDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room Details'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Room Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 2, // Add elevation for a card-like appearance
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DataTable(
                      dataRowHeight: 50, // Adjust the row height as needed
                      headingRowColor: MaterialStateProperty.all(
                          Colors.grey[300]), // Header row color
                      columns: const [
                        DataColumn(label: Text('Your Details')),
                        DataColumn(label: Text('Your Room Details')),
                      ],
                      rows: [], // Empty rows, no data for now
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}