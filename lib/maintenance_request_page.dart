import 'package:flutter/material.dart';

class MaintenanceRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maintenance Request'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Maintenance Request',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text('Add your maintenance request form here.'),
          ],
        ),
      ),
    );
  }
}