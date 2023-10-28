import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';

class AddHostel extends StatefulWidget {
  @override
  _AddHostelState createState() => _AddHostelState();
}

class _AddHostelState extends State<AddHostel> with SingleTickerProviderStateMixin {
  String? selectedValue = 'M';
  final TextEditingController hostelNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Enter Hostel Name',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        TextField(
          controller: hostelNameController,
          decoration: InputDecoration(
            hintText: 'Hostel Name',
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                Text('Male'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Female',
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            debugPrint('Button !');
            await insertHostel(hostelNameController.text, selectedValue!);
          },
          child: Text('Add Hostel'),
        ),
      ],
    );
  }
}


Future<void> insertHostel(String name, String gender) async {
  final conn = PostgreSQLConnection(
    'ep-delicate-poetry-06982532.ap-southeast-1.aws.neon.tech',
    5432,
   'neondb',
    username: 'ugy420',
    password: 'EDrb8Re2IWux',
  );
  
  try {
    await conn.open();
    // Perform database operations
    debugPrint("Worked!");
    await conn.query(
      'INSERT INTO hostel(name, gender) VALUES (@name, @gender)',
      substitutionValues: {
        'name': name,
        'gender': gender,
      },
    );
  } catch (e) {
    print('Error: $e');
  } finally {
    await conn.close();
  }
}