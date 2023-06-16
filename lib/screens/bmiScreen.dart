// ignore_for_file: prefer_const_constructors, unused_element, file_names

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../components/bottomNavbar.dart";
import "../components/drawerComponent.dart";
import "../components/header.dart";

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openTheDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return "Normal weight";
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  String name = "";
  late double heightOfPerson;
  late double weightOfPerson;
  double bmiCalculated = 0;
  String bmiCategory = "";

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        name = prefs.getString('userName')!;
        heightOfPerson = prefs.getDouble('userHeight')!;
        weightOfPerson = prefs.getDouble('userWeight')!;
        bmiCalculated = double.parse(
            calculateBMI(weightOfPerson, heightOfPerson / 100)
                .toStringAsFixed(2));
        bmiCategory = getBMICategory(bmiCalculated);
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
                        child: Text("Your BMI is $bmiCalculated",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.05),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Your BMI Category is $bmiCategory",
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
              BottomNavbar(indexOfThisScreen: 1)
            ],
          ),
        ));
  }
}
