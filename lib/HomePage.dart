import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/ApiClient.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var api = new ApiClient();
  var name = '';

  Future<void> _getUsers() async {
    setState(() {
      name = '';
    });

    try {
      var response = await api.getRequest('products');
      if (response.statusCode == 200) {
        var users = json.decode(response.body);
        setState(() {
          for (var user in users) {
            name += user['name'] + ' ';
          }
        });
      } else {
        print('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while fetching users: $e');
    }
  }

  bool toggle1 = false;
  bool toggle2 = false;
  bool toggle3 = false;

  Future<void> loadToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      toggle1 = prefs.getBool('toggle1') ?? false;
      toggle2 = prefs.getBool('toggle2') ?? false;
      toggle3 = prefs.getBool('toggle3') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(int.parse('0xFF1b212f')),
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getUsers,
              child: Text('Get all products'),
            ),
            Text(
              '$name',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '$toggle1',
              style: TextStyle(color: Colors.red),
            )
          ],
        )));
  }
}
