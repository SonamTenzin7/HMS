import 'package:flutter/material.dart';

class AddNotesFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Fill out the form for your maintenance:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Add your form fields (TextFields, buttons, etc.) here

            // Spacer to push buttons to the bottom
            Spacer(),

            // Align buttons to the bottom center
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Save Button
                  ElevatedButton(
                    onPressed: () {
                      // Handle the save action
                    },
                    child: Text('Save'),
                  ),
                  SizedBox(height: 10), // Adjust spacing as needed

                  // Cancel Button
                  TextButton(
                    onPressed: () {
                      // Handle the cancel action, e.g., navigate back
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
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
