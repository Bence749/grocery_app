import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool toggle1 = false;
  bool toggle2 = false;
  bool toggle3 = false;

  @override
  void initState()
  {
    super.initState();
    loadToggleValues();
  }

  Future<void> saveToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('toggle1', toggle1);
    await prefs.setBool('toggle2', toggle2);
    await prefs.setBool('toggle3', toggle3);
  }

  Future<void> loadToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      toggle1 = prefs.getBool('toggle1') ?? false;
      toggle2 = prefs.getBool('toggle2') ?? false;
      toggle3 = prefs.getBool('toggle3') ?? false;
    });
  }

  @override
  Widget build(BuildContext context)
  {
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
                  title: const Text('Toggle 1', style: TextStyle(color: Colors.white),),
                  value: toggle1,
                  onChanged: (bool value) {
                    setState(() {
                      toggle1 = value;
                    });
                    saveToggleValues();
                  },
                ),
                SwitchListTile(
                  title: const Text('Toggle 2', style: TextStyle(color: Colors.white),),
                  value: toggle2,
                  onChanged: (bool value) {
                    setState(() {
                      toggle2 = value;
                    });
                    saveToggleValues();
                  },
                ),
                SwitchListTile(
                  title: const Text('Toggle 3', style: TextStyle(color: Colors.white),),
                  value: toggle3,
                  onChanged: (bool value) {
                    setState(() {
                      toggle3 = value;
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