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
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(int.parse('0xFF1b212f')),
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: 
          <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.1, 20, screenSize.width * 0.1, 0,),
              child: Text('Welcome!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, color: Colors.white)
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.1, 10, screenSize.width * 0.1, 0,),
              child: Text('GroceryScan makes grocery shopping fun even with food allergies or specific dietary preferences!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF39EBB1))
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.1, 10, screenSize.width * 0.1, 0,),
              child: Text('All you have to do is \n1. Set your dietary preferences in your profile\n2. Scan barcode of items in grocery stores!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white)
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenSize.width * 0.1, 10, screenSize.width * 0.1, 0,),
              child: Text('GroceryScan will tell you if you can consume the scanned product or not based on your preferences. \nEnjoy your shopping!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFF39EBB1))
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0,0,0,0),
              child: Image.asset('assets/images/grocery_logo.jpg', height: screenSize.height * 0.3),
            ),
            /*
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0,),
              child: ElevatedButton(
              onPressed: _getUsers,
              child: Text('Get all products'),
              ),
            ),
            Text(
              '$name',
              style: TextStyle(color: Colors.red),
            ),
            Text('$toggle1', style: TextStyle(color: Colors.red),)
            */
          ],

        )));
  }
}
