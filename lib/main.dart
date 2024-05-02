import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_app/ProfilePage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'themes/themes.dart';

import 'HomePage.dart';
import 'ScanPage.dart';
import 'SettingsPage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  int _previousIndex = -1;
  ThemeMode _themeMode = ThemeMode.dark;

  void _onItemTapped(int index) {
    if(index != _selectedIndex)
      setState(() {
        _previousIndex = _selectedIndex;
        _selectedIndex = index;
      });
  }
  
  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GroceryScan",
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: MainApp(_selectedIndex, _onItemTapped, _previousIndex, toggleTheme: toggleTheme),
    );
  }
}

class MainApp extends StatelessWidget {
  final int _selectedIndex;
  final Function(int) _onItemTapped;
  final int _previousPage;
  final VoidCallback toggleTheme;

  MainApp(this._selectedIndex, this._onItemTapped, this._previousPage, {super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
    final List<Widget> _pages = [
      const HomePage(),
      const ScanPage(),
      const ProfilePage(),
      SettingsPage(toggleTheme: toggleTheme),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home), title: const Text("Home")),
          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.barcode),
              title: const Text("Scan product")),
          SalomonBottomBarItem(
              icon: const Icon(CupertinoIcons.profile_circled), title: const Text("Profile")),
        ],
        backgroundColor: theme.colorScheme.primary,
        currentIndex: _selectedIndex,
        selectedItemColor: theme.colorScheme.background,
        unselectedItemColor: theme.colorScheme.background,
        onTap: _onItemTapped,
        margin: EdgeInsets.fromLTRB(
            screenSize.width * 0.10, 0, screenSize.width * 0.10, 0),
      ),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Grocery',
              style: TextStyle(
                color: theme.colorScheme.secondary, // Color for the first part
              ),
            ),
            Text(
              'Scan', // Add space before the second part
              style: TextStyle(
                color:
                    theme.colorScheme.primary // Color for the second part
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.info_outline_rounded,
              size: 30,
            ),
            color: theme.colorScheme.primary,
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
        leading: _selectedIndex == 3 ? IconButton(
          icon: Icon(
            CupertinoIcons.arrow_left,
            color: theme.colorScheme.secondary, // Set the color to white
          ),
          onPressed: () {
            _onItemTapped(_previousPage);
          },
        ) : Container(),
      ),
      
    );
  }
}
