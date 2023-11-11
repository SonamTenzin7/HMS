import 'package:flutter/material.dart';

class RoomDetailsPage extends StatelessWidget {
  const RoomDetailsPage({super.key});

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
              'Room Number: ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Card(
                elevation: 2,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    
                    const SizedBox(height: 20), 
                    DataTable(
                      dataRowHeight: 50, 
                      headingRowColor: MaterialStateProperty.all(
                          Colors.grey[300]),
                      columns: const [
                        DataColumn(label: Text('Item')),
                        DataColumn(label: Text('Quantity')),
                      ],
                      rows: const [
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
