import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:grocery_app/mysql.dart';

import 'models/ProductModel.dart';
import 'services/DatabaseHandler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  var db = new MySql();
  var name = '';

  void _getUsers() async {
    name = '';
    var conn = await db.getConnection();
    var results = await conn.query('SELECT * FROM users');
    for (var row in results) {
      name = name + row[1] + ' ';
    }

    setState(() {
      name = name;
    });
    await conn.close();
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
