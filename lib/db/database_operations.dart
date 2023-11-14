import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/models/room.dart';
import 'package:studentlogin/models/student.dart';
import 'package:studentlogin/models/maintenance.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class AdminData{
  final String ip = "192.168.223.28";

  Future<List<Hostel>> retrieveHostels() async {
    final Uri url = Uri.parse('http://$ip:3000/api/allhostels');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Hostel> data = jsonData
          .map((entry) => Hostel.fromJson(entry as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<Hostel> retrieveHostel(int hid) async {
    final Uri url = Uri.parse('http://$ip:3000/api/hostel/$hid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic jsonData = json.decode(response.body);
      Hostel hostel = Hostel.fromJson(jsonData[0]);
      return hostel;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<void> insertHostel(String n, String g) async {
    final String name = n;
    final String gender = g;

    final String apiUrl = 'http://$ip:3000/api/addhostel';

    final Map<String, dynamic> data = {
      'name': name,
      'gender': gender,
    };

    final String jsonData = jsonEncode(data);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 201) {
      debugPrint('Hostel added successfully'+name+ " "+ gender);
    } else {
      debugPrint('Failed to add hostel. Status code: ${response.statusCode}');
    }
  }

  
  Future<bool> deleteHostel(int? hostelId, context) async {
  final Uri url = Uri.parse('http://$ip:3000/api/delhostel/$hostelId'); // Replace with your server URL and endpoint
  try {
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete the hostel $hostelId'),
        ),
      );
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
    }
  }

  Future<List<Room>> retrieveRooms() async{
    final Uri url = Uri.parse('http://$ip:3000/api/allrooms');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Room> data = jsonData
          .map((entry) => Room.fromJson(entry as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<List<Room>> retrieveRoomsByHostel(int? hid) async{
    final Uri url = Uri.parse('http://$ip:3000/api/allrooms/$hid');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<Room> data = jsonData
          .map((entry) => Room.fromJson(entry as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<bool> deleteRooms(int? hid, context) async{
    final Uri url = Uri.parse('http://$ip:3000/api/delrooms/$hid');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete the rooms of $hid'),
          ),
        );
        return false;
      }
    } catch (e) {
      
      print('Error: $e');
      return false;
    }
  }

  Future<bool> insertRoom(int no, int cap, int hid, context) async {
    try {
      final int roomno = no;
      final int capacity = cap;
      final String apiUrl = 'http://$ip:3000/api/addroom';

      final Map<String, dynamic> data = {
        'roomno': roomno,
        'capacity': capacity,
        'hid': hid
      };

      final String jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        debugPrint('Room Added');
        return true;
      } else if(response.statusCode == 409){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Duplicate room entry'),
          ),
        );
        return false; // Return false to indicate the operation failed.
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.toString()),
          ),
        );
        return false;
      }
    } catch (e) {
      // Handle the exception here, such as logging the error and status code.
      print('Error in insertRoom: $e');
      if (e is http.Response) {
        print('Status code: ${e.statusCode}');
      }
      return false; // Return false to indicate the operation failed.
    }
  }

  Future<bool> updateHostel(int id, String newname, String newgen, context) async {
    try {
      final String apiUrl = 'http://$ip:3000/api/updatehostel/$id'; // Replace with your server URL and endpoint

      final Map<String, dynamic> data = {
        'name': newname,
        'gender': newgen
      };

      final String jsonData = jsonEncode(data);

      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        debugPrint('Hostel updated successfully');
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update the hostel: Status code ${response.statusCode}'),
          ),
        );
        return false; // Return false to indicate the operation failed.
      }
    } catch (e) {
      print('Error in updateHostel: $e');
      return false;
    }
  }

  Future<bool> deleteRoom(int rid, int hid, context) async {
    final String apiUrl = 'http://$ip:3000/api/delroom?rid=$rid&hid=$hid';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update the hostel: Status code ${response.statusCode}'),
            ),
          );
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<List<Student>> retrieveCounsellors() async {
    final Uri url = Uri.parse('http://$ip:3000/api/allcounsellors');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      List<Student> data = jsonData
          .map((entry) => Student.fromJson(entry as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data from the API. Status code: ${response.statusCode}');
    }
  }

  Future<bool> deleteCounsellor(String stuId) async {
    final Uri url = Uri.parse('http://$ip:3000/api/delcounsellor/$stuId'); // Replace with your server URL and endpoint
    try {
      final response = await http.delete(url);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
      }
  }

  
  Future<List<Student>> retrieveStudents() async {
    final Uri url = Uri.parse('http://$ip:3000/api/allstudents');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      List<Student> data = jsonData
          .map((entry) => Student.fromJson(entry as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data from the API. Status code: ${response.statusCode}');
    }
  }

  Future<bool> insertCounsellor(int hid, String sid, context) async {
    try {

      final String apiUrl = 'http://$ip:3000/api/addcounsellor';

      final Map<String, dynamic> data = {
        'hid': hid,
        'sid': sid,
      };

      final String jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        debugPrint('Counesellor Added');
        return true;
      } else if(response.statusCode == 409){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Duplicate Counsellor entry'),
          ),
        );
        return false; // Return false to indicate the operation failed.
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.toString()),
          ),
        );
        return false;
      }
    } catch (e) {
      // Handle the exception here, such as logging the error and status code.
      print('Error in insertRoom: $e');
      if (e is http.Response) {
        print('Status code: ${e.statusCode}');
      }
      return false; // Return false to indicate the operation failed.
    }
  }

  Future<List<Hostel>> retrieveHostelnC() async {
    final Uri url = Uri.parse('http://$ip:3000/api/gethosncoun');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      List<Hostel> data = jsonData
          .map((entry) => Hostel.fromJson(entry as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data from the API. Status code: ${response.statusCode}');
    }
  }

  Future<List<Student>> retrieveRoomDetail(int id) async{
    final Uri url = Uri.parse("http://$ip:3000/api/getroomdetails/$id"); 
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List<dynamic> jsonData = json.decode(response.body);
      
      List<Student> studentslist = jsonData
        .map((entry) => Student.fromJson(entry as Map<String, dynamic>))
        .toList();
      return studentslist;
    } else {
      throw Exception('Failed to load students in the room.');
    }
  }

  Future<List<Room>> retrieveAllotee() async{
    final Uri url = Uri.parse("http://$ip:3000/api/getallotee");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List<dynamic> jsonData = json.decode(response.body);
      
      List<Room> studentslist = jsonData
        .map((entry) => Room.fromJson(entry as Map<String, dynamic>))
        .toList();
      return studentslist;
    } else {
      throw Exception('Failed to load students in the room.');
    }
  }

  Future<bool> insertAllocation(int rid, String sid, context) async {
    try {

      final String apiUrl = 'http://$ip:3000/api/addallocation';

      final Map<String, dynamic> data = {
        'rid': rid,
        'sid': sid,
      };

      final String jsonData = jsonEncode(data);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Assigned Successfully!'),
          ),
        );
        return true;
      } else if(response.statusCode == 409){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Duplicate entry for ${sid}'),
          ),
        );
        return false;
      } else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.toString()),
          ),
        );
        return false;
      }
    } catch (e) {
      print('Error in insertRoom: $e');
      if (e is http.Response) {
        print('Status code: ${e.statusCode}');
      }
      return false;
    }
  }

  Future<Student> getStudent(String id) async {
  final Uri url = Uri.parse("http://$ip:3000/api/getstudent/$id");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    if (jsonData.isNotEmpty) {
      Student student = Student.fromJson(jsonData.first as Map<String, dynamic>);
      return student;
    } else {
      throw Exception('No student data found for ID: $id');
    }
    } else {
    throw Exception('Failed to load student data.');
    }
  }

  Future<Room> getRoomDetailsByStudent(String id) async {
  final Uri url = Uri.parse("http://$ip:3000/api/getroom/$id");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    if (jsonData.isNotEmpty) {
      Room room = Room.fromJson(jsonData.first as Map<String, dynamic>);
      return room;
    } else {
      throw Exception('No student data found for ID: $id');
    }
    } else {
      throw Exception('Failed to load room data.');
    }
  }

  Future<List<Maintenance>> getMaintenanceByStudent(String std) async{
    final Uri url = Uri.parse("http://$ip:3000/api/getmaintenance/$std"); 
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List<dynamic> jsonData = json.decode(response.body);
      
      List<Maintenance> maintenance = jsonData
        .map((entry) => Maintenance.fromJson(entry as Map<String, dynamic>))
        .toList();
      return maintenance;
    } else {
      throw Exception('Failed to load students in the room.');
    }
  }

  Future<Room> getRoomByStudent(String id) async {
  final Uri url = Uri.parse("http://$ip:3000/api/gethostelbstudent/$id");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);

    if (jsonData.isNotEmpty) {
      Room room = Room.fromJson(jsonData.first as Map<String, dynamic>);
      return room;
    } else {
      throw Exception('No student data found for ID: $id');
    }
    } else {
    throw Exception('Failed to load student data.');
    }
  }

  Future<bool> insertMaintenance(String studentId, int roomNo, String desc, String date, String status, context) async {
  try {
    final String apiUrl = 'http://$ip:3000/api/addmaintenance';

    final Map<String, dynamic> data = {
      'studentId': studentId,
      'roomNo': roomNo,
      'des': desc,
      'date': date,
      'status': status,
    };

    final String jsonData = jsonEncode(data);

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maintenance Submitted!'),
        ),
      );
      return true;
    } else if (response.statusCode == 409) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maintenance update failed: Duplicate entry'),
        ),
      );
      return false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send maintenance request: ${response.statusCode}'),
        ),
      );
      return false;
    }
  } catch (e) {
    print('Error in requesting Maintenance: $e');
    return false;
  }
  } 
  Future<bool> deleteMaintenance(int id) async {
    final Uri url = Uri.parse('http://$ip:3000/api/delmaintenance/$id');
    try {
      final response = await http.delete(url);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<bool> removeAllocation(String stuId) async {
    final Uri url = Uri.parse('http://$ip:3000/api/delallo/$stuId'); // Replace with your server URL and endpoint
    try {
      final response = await http.delete(url);

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
      }
  }

   Future<List<Maintenance>> retrieveMaintenanceRequests() async{
    final Uri url = Uri.parse("http://$ip:3000/api/getmr"); 
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List<dynamic> jsonData = json.decode(response.body);
      
      List<Maintenance> maintenance = jsonData
        .map((entry) => Maintenance.fromJson(entry as Map<String, dynamic>))
        .toList();
      return maintenance;
    } else {
      throw Exception('Failed to load maintenance req.');
    }
  }

   Future<void> rejectMaintenance(int id) async {
    final Uri url = Uri.parse('http://$ip:3000/api/delmain/$id');
    try {
    await http.delete(url);
    } catch (e) {
      print('Error: $e');
      }
  }

  Future<void> acceptMaintenance(int id) async {
    final Uri url = Uri.parse('http://$ip:3000/api/accmain/$id');
    try {
      await http.put(url);
    } catch (e) {
      print('Error: $e');
      }
  }

  Future<List<Maintenance>> retrieveMaintenanceRequestsOld() async{
    final Uri url = Uri.parse("http://$ip:3000/api/getmrold"); 
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List<dynamic> jsonData = json.decode(response.body);
      
      List<Maintenance> maintenance = jsonData
        .map((entry) => Maintenance.fromJson(entry as Map<String, dynamic>))
        .toList();
      return maintenance;
    } else {
      throw Exception('Failed to load maintenance req.');
    }
  }
}
