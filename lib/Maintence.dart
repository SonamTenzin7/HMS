import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance'), // Change the app bar title to "Maintenance".
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
                'Maintenance', // Change the title within the card to "Maintenance".
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    'Show',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: DropdownButton<String>(
                    value: '2',
                    onChanged: (val) {},
                    items: ['1', '2', '3', '4'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    'entries',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Text(
                    'Search:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'Search',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView( // Wrap DataTable in SingleChildScrollView
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 40.0, // Increase the column spacing
                  columns: [
                    DataColumn(
                      label: Text('Hostel Name'), // Add a column for Hostel Name.
                    ),
                    DataColumn(
                      label: Text('Room Number'),
                    ),
                    DataColumn(
                      label: Text('Date'), // Add a column for Date.
                    ),
                    DataColumn(
                      label: Text('Actions'), // Add a column for Actions.
                    ),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text('Hostel Name')), // Add data for Hostel Name.
                        DataCell(Text('101')),
                        DataCell(Text('Date Data')), // Add data for Date.
                        DataCell(
                          // Add an icon inside a circular icon for Actions.
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.info, // Replace 'Icons.info' with your desired icon.
                                color: Colors.white,
                              ),
                            ),
                          ),
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

void main() {
  runApp(MaterialApp(
    home: HomePageWidget(),
  ));
}
