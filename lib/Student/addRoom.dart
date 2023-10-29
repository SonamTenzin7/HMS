import 'package:flutter/material.dart';

class AddRoomWidget extends StatefulWidget {
  @override
  _AddRoomWidgetState createState() => _AddRoomWidgetState();
}

class _AddRoomWidgetState extends State<AddRoomWidget> {
  TextEditingController roomNoController = TextEditingController();
  TextEditingController roomCapacityController = TextEditingController();
  TextEditingController hostelController = TextEditingController();
  FocusNode roomNoFocusNode = FocusNode();
  FocusNode roomCapacityFocusNode = FocusNode();
  FocusNode hostelFocusNode = FocusNode();
  String? selectedType;

  @override
  void dispose() {
    roomNoController.dispose();
    roomCapacityController.dispose();
    hostelController.dispose();
    roomNoFocusNode.dispose();
    roomCapacityFocusNode.dispose();
    hostelFocusNode.dispose();
    super.dispose();
  }

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
                'Room No',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: roomNoController,
                  focusNode: roomNoFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Enter Room No',
                    labelStyle: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Text(
                'Capacity',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: roomCapacityController,
                  focusNode: roomCapacityFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Enter Capacity',
                    labelStyle: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Text(
                'Hostel',
                style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: TextFormField(
                  controller: hostelController,
                  focusNode: hostelFocusNode,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Enter Hostel',
                    labelStyle: TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Color(0xFF57636C),
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
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
                      primary: Color.fromARGB(255, 83, 24, 220),
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
    home: AddRoomWidget(),
  ));
}