import 'package:studentlogin/models/hostel.dart';
import 'package:studentlogin/models/room.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class AdminData{
  final String ip = "localhost";

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
      // Hostel deleted successfully
      return true;
    } else {
      // Handle the case where the delete request was not successful
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete the hostel $hostelId'),
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
      // Hostel deleted successfully
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
}
