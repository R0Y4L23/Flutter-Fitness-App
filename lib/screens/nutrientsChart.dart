// ignore_for_file: prefer_const_constructors_in_immutables, unused_element, prefer_const_constructors, file_names

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../components/bottomNavbar.dart";
import "../components/drawerComponent.dart";
import "../components/header.dart";

class NutrientChart extends StatefulWidget {
  NutrientChart({Key? key}) : super(key: key);

  @override
  State<NutrientChart> createState() => _NutrientChartState();
}

class _NutrientChartState extends State<NutrientChart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openTheDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  String name = "";

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
                        child: Text("Nutrients Chart",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                    ],
                  ),
                ),
              ),
              BottomNavbar(indexOfThisScreen: 2)
            ],
          ),
        ));
  }
}
