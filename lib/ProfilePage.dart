import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool userVegan = false;
  bool userVegetarian = false;
  bool userHalal = false;

  @override
  void initState() {
    super.initState();
    loadToggleValues();
  }

  Future<void> saveToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userVegan', userVegan);
    await prefs.setBool('userVegetarian', userVegetarian);
    await prefs.setBool('userHalal', userHalal);
  }

  Future<void> loadToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userVegan = prefs.getBool('userVegan') ?? false;
      userVegetarian = prefs.getBool('userVegetarian') ?? false;
      userHalal = prefs.getBool('userHalal') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Icon(
                  CupertinoIcons.profile_circled,
                  size: 150,
                  color: Color(int.parse('0xFF3dfbbd')),
                ),
                SwitchListTile(
                  activeColor: Color(int.parse('0xFF3dfbbd')),
                  title: const Text(
                    'Vegan',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: userVegan,
                  onChanged: (bool value) {
                    setState(() {
                      userVegan = value;
                    });
                    saveToggleValues();
                  },
                ),
                SwitchListTile(
                  activeColor: Color(int.parse('0xFF3dfbbd')),
                  title: const Text(
                    'Vegetarian',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: userVegetarian,
                  onChanged: (bool value) {
                    setState(() {
                      userVegetarian = value;
                    });
                    saveToggleValues();
                  },
                ),
                SwitchListTile(
                  activeColor: Color(int.parse('0xFF3dfbbd')),
                  title: const Text(
                    'Halal',
                    style: TextStyle(color: Colors.white),
                  ),
                  value: userHalal,
                  onChanged: (bool value) {
                    setState(() {
                      userHalal = value;
                    });
                    saveToggleValues();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
