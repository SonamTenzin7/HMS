import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/models/room.dart';
import 'package:studentlogin/models/student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class AdminData{
  final String ip = "10.2.8.79";

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

  Future<List<Room>> retrieveRooms(int? hid) async{
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
        // Handle the case where the delete request was not successful
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete the rooms of $hid'),
          ),
        );
        return false;
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
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
      // Handle any errors that occur during the HTTP request
      print('Error in updateHostel: $e');
      return false;
    }
  }

  Future<bool> deleteRoom(int rid, int hid, context) async {
    final String apiUrl = 'http://$ip:3000/api/delroom?rid=$rid&hid=$hid';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Room deletion was successful
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
      // Handle network or other errors
      // You can also show an error message here
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
        'sid': sid
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
}


