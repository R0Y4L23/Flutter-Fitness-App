// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, avoid_unnecessary_containers, unused_local_variable, avoid_print, unused_import

import 'dart:convert';

import 'package:fitness_app/components/bottomNavbar.dart';
import 'package:fitness_app/components/drawerComponent.dart';
import 'package:fitness_app/components/header.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openTheDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  String name = "";

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("The username is");
    print(prefs.getString('userName'));
    try {
      setState(() {
        String username = prefs.getString('userName')!;
        name = username;
      });
    } catch (e) {
      print(e.toString());
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
                        child: Text("Today's Target",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Target Calories",
                                  style: TextStyle(
                                      color: Colors.grey, letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "800 Cals",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            Image.asset(
                              "assets/calories.png",
                              height: 100,
                              width: 100,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Burnt Calories",
                                  style: TextStyle(
                                      color: Colors.grey, letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "800 Cals",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Target Steps",
                                  style: TextStyle(
                                      color: Colors.grey, letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "8000",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            Image.asset(
                              "assets/footsteps.png",
                              height: 100,
                              width: 100,
                            ),
                            Column(
                              children: [
                                Text(
                                  "Finished Steps",
                                  style: TextStyle(
                                      color: Colors.grey, letterSpacing: 1.5),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "2000",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.035),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Weekly Goals",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.purple.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      "SUNDAY",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 3),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/footsteps.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/calories.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.indigo.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      "MONDAY",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 3),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/footsteps.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/calories.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.teal.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      "TUESDAY",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 3),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/footsteps.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/calories.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      "WEDNESDAY",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 3),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/footsteps.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/calories.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.pink.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      "THURSDAY",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 3),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/footsteps.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/calories.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      "FRIDAY",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 3),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/footsteps.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/calories.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 12),
                                padding: EdgeInsets.all(10),
                                height: 120,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade200,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      "SATURDAY",
                                      style: TextStyle(
                                          fontSize: 16, letterSpacing: 3),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/footsteps.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/calories.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        Text(" :  500")
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BottomNavbar(indexOfThisScreen: 0)
            ],
          ),
        ));
  }
}
