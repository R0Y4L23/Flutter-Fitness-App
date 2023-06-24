// ignore_for_file: prefer_const_constructors_in_immutables, unused_element, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottomNavbar.dart';
import '../components/drawerComponent.dart';
import '../components/header.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openTheDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  String name = "";
  bool _isDarkModeEnabled = false;
  bool _areNotificationsEnabled = true;

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        String username = prefs.getString('userName')!;
        name = username;
      });
    } catch (e) {
      name = "User";
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double getHeight(h) {
      return height * h;
    }

    double getWidth(w) {
      return width * w;
    }

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: DrawerComponent(
          name: name,
        ),
        body: SizedBox(
          height: getHeight(0.98),
          child: Stack(
            children: [
              Positioned(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        openTheDrawer: openTheDrawer,
                        name: name,
                      ),
                      SizedBox(
                        height: getHeight(0.05),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Settings",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      SwitchListTile(
                        title: Text('Dark Mode'),
                        value: _isDarkModeEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isDarkModeEnabled = value;
                            // Apply dark mode logic here
                          });
                        },
                      ),
                      SwitchListTile(
                        title: Text('Notifications'),
                        value: _areNotificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            _areNotificationsEnabled = value;
                            // Apply notifications logic here
                          });
                        },
                      ),
                      ListTile(
                        title: Text('Account'),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // Navigate to account settings screen
                        },
                      ),
                      ListTile(
                        title: Text('Privacy'),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // Navigate to privacy settings screen
                        },
                      ),
                      ListTile(
                        title: Text('Terms and Conditions'),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // Navigate to terms and conditions screen
                        },
                      ),
                      ListTile(
                        title: Text('Help and Support'),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // Navigate to help and support screen
                        },
                      ),
                    ],
                  ),
                ),
              ),
              BottomNavbar(indexOfThisScreen: 1)
            ],
          ),
        ));
  }
}
