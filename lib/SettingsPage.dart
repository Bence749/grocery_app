import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.toggleTheme}) : super(key: key);
  final VoidCallback toggleTheme;
  
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  bool userDarkMode = true;

  @override
  void initState() {
    super.initState();
    loadToggleValues();
  }

  Future<void> saveToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userDarkMode', userDarkMode);
  }

  Future<void> loadToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userDarkMode = prefs.getBool('userDarkMode') ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
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
    
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: screenSize.width * 0.8,
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: theme.colorScheme.background,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Send us feedback", textAlign: TextAlign.center, style: TextStyle(color: theme.colorScheme.secondary, fontSize: 30)),
                            GestureDetector(
                              child: Text("hello@groceryapp.com", textAlign: TextAlign.center, style: TextStyle(color: theme.colorScheme.primary, fontSize: 20)),
                              onTap: () => _launchURL("hello@groceryapp.com", "Feedback")
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    width: screenSize.width * 0.8,
                    child: Container(
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: theme.colorScheme.background,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Set color theme", textAlign: TextAlign.center, style: TextStyle(color: theme.colorScheme.secondary, fontSize: 30)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Light", style: TextStyle(color: theme.colorScheme.secondary, fontSize: 20)),
                                Switch(
                                  value: userDarkMode,
                                  activeColor: theme.colorScheme.primary,
                                  inactiveTrackColor: theme.colorScheme.background,
                                  onChanged: (value) {
                                    setState(() {
                                      userDarkMode = value;
                                    });
                                    saveToggleValues();
                                    widget.toggleTheme(); // Call the toggleTheme function passed from MainApp
                                  },
                                ),
                                Text("Dark", style: TextStyle(color: theme.colorScheme.secondary, fontSize: 20))
                              ]
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  }

