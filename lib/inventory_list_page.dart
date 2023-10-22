import 'package:flutter/material.dart';

class RoomDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory List'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Room Number: ', // fetching from database
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 2, // Add elevation for a card-like appearance
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    
                    const SizedBox(height: 20), // Add spacing
                    DataTable(
                      dataRowHeight: 50, // Adjust the row height as needed
                      headingRowColor: MaterialStateProperty.all(
                          Colors.grey[300]), // Header row color
                      columns: const [
                        DataColumn(label: Text('Item')),
                        DataColumn(label: Text('Quantity')),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Text('Chair')),
                            DataCell(Text('6')),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Text('Table')),
                            DataCell(Text('5')),
                          ],
                        ),
                        // Add more rows as needed
                      ],
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
