import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel_Name'),
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: IconButton(
            icon: Icon(
              Icons.density_medium_sharp,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () {
              print('IconButton pressed ...');
            },
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Hostel_Name',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 25, 0, 0),
                  child: Text(
                    'Show',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                  child: DropdownButton<String>(
                    value: '2',
                    onChanged: (val) {},
                    items: ['1', '2', '3', '4']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                  child: Text(
                    'entries',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                  child: Text(
                    'Search by:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 25, 8, 0),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Search...',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                dataRowMaxHeight: 70, // Set the desired row height
                columns: [
                  DataColumn(
                    label: Text('Room Number'),
                  ),
                  DataColumn(
                    label: Text('Occupants'),
                  ),
                  DataColumn(
                    label: Text('Student Number'),
                  ),
                  DataColumn(
                    label: Text('Vacancy'),
                  ),
                ],
                rows: [
                  DataRow(
                    cells: [
                      DataCell(Text('101')),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Pema Wangyel'),
                            Text('Nima Yoezer'),
                            Text('Sonam Tenzin'),
                            Text('Ugyen Wangda Gyeltshen'),
                          ],
                        ),
                      ),
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('02210213'),
                            Text('02210211'),
                            Text('02210217'),
                            Text('02210218'),
                          ],
                        ),
                      ),
                      DataCell(
                        Column(
                          children: [
                            Text('0/4', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePageWidget(),
  ));
}
