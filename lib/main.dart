import 'package:flutter/material.dart';
import 'package:grocery_app/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mysql1/mysql1.dart';

import 'HomePage.dart';
import 'ScanPage.dart';
import 'SettingsPage.dart';
import 'services/DatabaseHandler.dart';

void main() async {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget
{
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "Grocery App",
      theme: ThemeData(primarySwatch: const MaterialColor(0xFF1b212f, {
        50: Color(0xFFE7E7E7),
        100: Color(0xFFE7E7E7),
        200: Color(0xFFE7E7E7),
        300: Color(0xFFE7E7E7),
        400: Color(0xFFE7E7E7),
        500: Color(0xFF1b212f), // Main color
        600: Color(0xFF39EBB1), // Secondary color
        700: Color(0xFF777375),
        800: Color(0xFF777375),
        900: Color(0xFF777375),
      })),
      home: MainApp(_selectedIndex, _onItemTapped),
    );
  }
}

class MainApp extends StatelessWidget
{
  final int _selectedIndex;
  final Function(int) _onItemTapped;

  final List<Widget> _pages = [const HomePage(), const ScanPage(), const SettingsPage(), const ProfilePage()];

  MainApp(this._selectedIndex, this._onItemTapped, {super.key});

  @override
  Widget build(BuildContext context)
  {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
          items: [
            SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text("Home")),
            SalomonBottomBarItem(icon: const Icon(CupertinoIcons.barcode), title: const Text("Scan product")),
            SalomonBottomBarItem(icon: const Icon(Icons.settings), title: const Text("Settings")),
          ],
          backgroundColor: Color(int.parse('0xFF3dfbbd')),
          currentIndex: _selectedIndex,
          selectedItemColor: Color(int.parse('0xFF161a1f')),
          onTap: _onItemTapped,
          margin: EdgeInsets.fromLTRB(screenSize.width * 0.10, 0, screenSize.width * 0.10, 0),
        ),
      appBar: AppBar(
        backgroundColor: Color(int.parse('0xFF1b212f')),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Grocery',
              style: TextStyle(
                color: Colors.white, // Color for the first part
              ),
            ),
            Text(
              'Scan', // Add space before the second part
              style: TextStyle(
                color: Color(int.parse('0xFF3dfbbd')), // Color for the second part
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(CupertinoIcons.profile_circled, size: 30,),
            color: Color(int.parse('0xFF3dfbbd')),
            onPressed: (){
              _onItemTapped(3);
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(
          CupertinoIcons.arrow_left,
          color: Colors.white, // Set the color to white
        ),
  onPressed: (){},
),
      ),
    );
  }
}