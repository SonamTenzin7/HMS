import 'package:flutter/material.dart';


class AddHostelWidget extends StatefulWidget {
  @override
  _AddHostelWidgetState createState() => _AddHostelWidgetState();
}

class _AddHostelWidgetState extends State<AddHostelWidget> {
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hostel Name',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF14181B),
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                ),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Enter Hostel Name',
                  labelStyle: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF57636C),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Type',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Radio<String>(
                      value: 'Male',
                      groupValue: _selectedType,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio<String>(
                      value: 'Female',
                      groupValue: _selectedType,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                    Text('Female'),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      print('Cancel button pressed ...');
                    },
                    style: TextButton.styleFrom(
                      primary: Color.fromARGB(255, 117, 54, 244),
                    ),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      print('Add button pressed ...');
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color(0xFF4B39EF),
                    ),
                    child: Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddHostelWidget(),
  ));
}