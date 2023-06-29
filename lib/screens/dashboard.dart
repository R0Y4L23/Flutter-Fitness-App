// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element, avoid_unnecessary_containers, unused_local_variable, avoid_print, unused_import, unused_field, prefer_interpolation_to_compose_strings, await_only_futures

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fitness_app/components/bottomNavbar.dart';
import 'package:fitness_app/components/drawerComponent.dart';
import 'package:fitness_app/components/header.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pedometer/pedometer.dart';

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
  int targetCal = 0;
  int targetSteps = 0;

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    targetCal = prefs.getInt("calories") ?? 800;
    targetSteps = prefs.getInt("steps") ?? 8000;

    print(prefs.getString('userID'));

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

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '0';

  void onStepCount(StepCount event) {
    print("Step Count");
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print("Status Changed");
    print(event);
    setState(() {
      _status = event.status;
    });

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                title: 'Status',
                body: 'Now ' + _status,
                actionType: ActionType.Default));
      }
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  Future<void> initPlatformState() async {
    print("Pedometer is formed");
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    initPlatformState();
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
                                  "$targetCal Cals",
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
                                  "${(double.parse(_steps) * 0.05).toStringAsFixed(2)} Cals",
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
                                  targetSteps.toString(),
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
                                  _steps,
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
                                          fontSize: 16,
                                          letterSpacing: 3.5,
                                          fontWeight: FontWeight.w900),
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
                                          fontSize: 16,
                                          letterSpacing: 3.5,
                                          fontWeight: FontWeight.bold),
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
                                          fontSize: 16,
                                          letterSpacing: 3.5,
                                          fontWeight: FontWeight.bold),
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
                                          fontSize: 16,
                                          letterSpacing: 3.5,
                                          fontWeight: FontWeight.bold),
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
                                          fontSize: 16,
                                          letterSpacing: 3.5,
                                          fontWeight: FontWeight.bold),
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
                                          fontSize: 16,
                                          letterSpacing: 3.5,
                                          fontWeight: FontWeight.bold),
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
                                          fontSize: 16,
                                          letterSpacing: 3.5,
                                          fontWeight: FontWeight.bold),
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
