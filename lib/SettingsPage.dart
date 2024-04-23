import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      body: Center(
        child: Text("WORK IN PROGRESS", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 40))
      ),
    );
  }
}
