// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, avoid_unnecessary_containers, unused_local_variable

import 'package:fitness_app/components/bottomNavbar.dart';
import 'package:fitness_app/components/drawerComponent.dart';
import 'package:fitness_app/components/header.dart';
import "package:flutter/material.dart";

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
        endDrawer: DrawerComponent(),
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
                                  "Total Calories",
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
                                  "Total Steps",
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
