import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_app/ApiClient.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  var api = new ApiClient();
  var name = '';

  Future<void> _getUsers() async {
    setState(() {
      name = '';
    });

    try {
      var response = await api.getRequest('products');
      if (response.statusCode == 200) {
        // Successfully fetched users
        var users = json.decode(response.body);
        setState(() {
          for (var user in users) {
            name += user['name'] + ' ';
          }
        });
      } else {
        // Error handling
        print('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      // Exception handling
      print('Exception while fetching users: $e');
    }
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
              child: Text('Get Users'),
            ),
            Text('$name', style: TextStyle(color: Colors.red),),
          ],
        )
      )
    );
  }
}
