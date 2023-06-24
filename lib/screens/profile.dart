// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_element, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottomNavbar.dart';
import '../components/drawerComponent.dart';
import '../components/header.dart';
import '../components/textFieldWithIcon.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openTheDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  String name = "";
  String _selectedGender = "male";

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
                        child: Text("Update Your Profile",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      TextFieldWithIcon(
                        icon: Icons.person,
                        label: 'Name',
                        placeholder: 'Type here',
                      ),
                      SizedBox(height: 16.0),
                      TextFieldWithIcon(
                        icon: Icons.calendar_today,
                        label: 'Age',
                        placeholder: 'Type here',
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          )),
                      SizedBox(height: 8.0),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 50,
                            padding:
                                EdgeInsets.only(left: 12, right: 12, top: 18),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              value: _selectedGender,
                              decoration:
                                  InputDecoration.collapsed(hintText: ''),
                              hint: Text('Gender'),
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'female',
                                  child: Text('Female'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              },
                            ),
                          )),
                      SizedBox(height: 16.0),
                      TextFieldWithIcon(
                        icon: Icons.height,
                        label: 'Height',
                        placeholder: 'Type here (CM)',
                      ),
                      SizedBox(height: 16.0),
                      TextFieldWithIcon(
                        icon: Icons.local_fire_department,
                        label: 'Weight',
                        placeholder: 'Type here (KG)',
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle form submission
                            },
                            child: Text('Save'),
                          )),
                      SizedBox(
                        height: getWidth(0.1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Update Your Goals",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      TextFieldWithIcon(
                        icon: Icons.food_bank,
                        label: 'Calories',
                        placeholder: 'Type here',
                      ),
                      SizedBox(height: 16.0),
                      TextFieldWithIcon(
                        icon: Icons.assist_walker,
                        label: 'Steps',
                        placeholder: 'Type here',
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle form submission
                            },
                            child: Text('Save'),
                          )),
                      SizedBox(
                        height: getHeight(0.12),
                      )
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
