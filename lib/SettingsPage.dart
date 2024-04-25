import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> _launchURL(String toMailId, String subject) async {
      try {
        var url = 'mailto:$toMailId?subject=$subject';
        if (await canLaunchUrlString(url)) {
          debugPrint("Launching $url");
          await launchUrlString(url);
        } else {
          throw 'Could not launch $url';
        }
      } catch (e) {
        debugPrint('Error launching URL: $e');
        // Handle error gracefully, like showing a snackbar or logging.
      }
    }

    return Scaffold(
      backgroundColor: Color(int.parse('0xFF1b212f')),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(
                color: Color(int.parse('0xFF39EBB1')),
                width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Color(int.parse('0xFF1b212f')),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
            children: [
              Text("Send us feedback", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30)),
              GestureDetector(
                child: Text("hello@groceryapp.com", textAlign: TextAlign.center, style: TextStyle(color: Color(int.parse('0xFF39EBB1')), fontSize: 20)),
                onTap: () => _launchURL("hello@groceryapp.com", "Feedback")
              )
            ],
          ),
          ),
        ),
      ),
    );
  }
}
