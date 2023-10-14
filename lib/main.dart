import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'ListPage.dart';
import 'HelpPage.dart';

void main() => runApp(const MyApp());

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
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainApp(_selectedIndex, _onItemTapped),
    );
  }
}

class MainApp extends StatelessWidget
{
  final int _selectedIndex;
  final Function(int) _onItemTapped;

  final List<Widget> _pages = [HomePage(), ListPage(), HelpPage()];

  MainApp(this._selectedIndex, this._onItemTapped, {super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Grocery list"),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: "Help"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
    );
  }
}