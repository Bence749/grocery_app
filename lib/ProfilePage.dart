import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool userVegan = false;
  bool userVegetarian = false;
  bool userGlutenFree = false;
  bool userEggFree = false;
  bool userFishFree = false;
  bool userCrustaceansFree = false;
  bool userDairyFree = false;
  bool userPaleo = false;
  bool userAddedSugarFree = false;

  @override
  void initState() {
    super.initState();
    loadToggleValues();
  }

  Future<void> saveToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('userVegan', userVegan);
    await prefs.setBool('userVegetarian', userVegetarian);
    await prefs.setBool('userGlutenFree', userGlutenFree);
    await prefs.setBool('userEggFree', userEggFree);
    await prefs.setBool('userFishFree', userFishFree);
    await prefs.setBool('userCrustaceansFree', userCrustaceansFree);
    await prefs.setBool('userDairyFree', userDairyFree);
    await prefs.setBool('userPaleo', userPaleo);
    await prefs.setBool('userAddedSugarFree', userAddedSugarFree);
  }

  Future<void> loadToggleValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userVegan = prefs.getBool('userVegan') ?? false;
      userVegetarian = prefs.getBool('userVegetarian') ?? false;
      userGlutenFree = prefs.getBool('userGlutenFree') ?? false;
      userEggFree = prefs.getBool('userEggFree') ?? false;
      userFishFree = prefs.getBool('userFishFree') ?? false;
      userCrustaceansFree = prefs.getBool('userCrustaceansFree') ?? false;
      userDairyFree = prefs.getBool('userDairyFree') ?? false;
      userPaleo = prefs.getBool('userPaleo') ?? false;
      userAddedSugarFree = prefs.getBool('userAddedSugarFree') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(10,15,10,0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Icon(
                      CupertinoIcons.profile_circled,
                      size: 100,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                            'Vegan',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.seedling, color: theme.colorScheme.primary, size: 25,)
                      ],),
                    value: userVegan,
                    onChanged: (bool value) {
                      setState(() {
                        userVegan = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                    ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,                    
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                            'Vegetarian',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.leaf, color: theme.colorScheme.primary, size: 25,)
                      ],),
                    value: userVegetarian,
                    onChanged: (bool value) {
                      setState(() {
                        userVegetarian = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                  ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                            'Paleo',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.drumstickBite, color: theme.colorScheme.primary, size: 20,)
                      ],),
                    value: userPaleo,
                    onChanged: (bool value) {
                      setState(() {
                        userPaleo = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                    ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                            'Gluten Free',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.breadSlice, color: theme.colorScheme.primary, size: 20,)
                      ],),
                    value: userGlutenFree,
                    onChanged: (bool value) {
                      setState(() {
                        userGlutenFree = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                    ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                            'Egg Free',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.egg, color: theme.colorScheme.primary, size: 20,)
                      ],),
                    value: userEggFree,
                    onChanged: (bool value) {
                      setState(() {
                        userEggFree = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                    ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                            'Fish Free',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.fishFins, color: theme.colorScheme.primary, size: 20,)
                      ],),
                    value: userFishFree,
                    onChanged: (bool value) {
                      setState(() {
                        userFishFree = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                    ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                          'Crustaceans Free',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.shrimp, color: theme.colorScheme.primary, size: 20,)
                      ],),
                    value: userCrustaceansFree,
                    onChanged: (bool value) {
                      setState(() {
                        userCrustaceansFree = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                    ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                          'Dairy Free',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.cow, color: theme.colorScheme.primary, size: 20,)
                      ],),
                    value: userDairyFree,
                    onChanged: (bool value) {
                      setState(() {
                        userDairyFree = value;
                      });
                      saveToggleValues();
                    },
                  ),
                  Container(
                    width: screenSize.width * 0.8,
                    child: Divider(
                      color: theme.colorScheme.primary,
                      height: 1,
                      thickness: 1,
                    ),),
                  SwitchListTile(
                    activeColor: theme.colorScheme.primary,
                    inactiveTrackColor: theme.colorScheme.background,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0), // Adjust the right padding as needed
                          child: Text(
                          'Added Sugar Free',
                            style: TextStyle(color: theme.colorScheme.secondary),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                        FaIcon(FontAwesomeIcons.cubesStacked, color: theme.colorScheme.primary, size: 20,)
                      ],),
                    value: userAddedSugarFree,
                    onChanged: (bool value) {
                      setState(() {
                        userAddedSugarFree= value;
                      });
                      saveToggleValues();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
