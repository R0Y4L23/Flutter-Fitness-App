// ignore_for_file: prefer_const_constructors_in_immutables, file_names, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, avoid_print, sort_child_properties_last

import 'dart:convert';

import 'package:fitness_app/components/drawerComponent.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../components/bottomNavbar.dart';
import '../components/header.dart';

class MealPlanner extends StatefulWidget {
  MealPlanner({Key? key}) : super(key: key);

  @override
  State<MealPlanner> createState() => _MealPlannerState();
}

class _MealPlannerState extends State<MealPlanner> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openTheDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  List<Map<String, String>> allFoods = [];
  List<Map<String, String>> breakfast = [];
  List<Map<String, String>> lunch = [];
  List<Map<String, String>> snack = [];
  List<Map<String, String>> dinner = [];

  void addToFoodList() {
    setState(() {
      allFoods.add({"foodId": foodId, "label": label, "image": image});
    });
  }

  void addToBreakfastList(String id) {
    Map<String, String> temp = {};
    for (int i = 0; i < allFoods.length; i++) {
      if (allFoods[i]["foodId"] == id) {
        temp = allFoods[i];
        break;
      }
    }
    setState(() {
      breakfast.add(temp);
    });
  }

  void addToLunchList(String id) {
    Map<String, String> temp = {};
    for (int i = 0; i < allFoods.length; i++) {
      if (allFoods[i]["foodId"] == id) {
        temp = allFoods[i];
        break;
      }
    }
    setState(() {
      lunch.add(temp);
    });
  }

  void addToSnacksList(String id) {
    Map<String, String> temp = {};
    for (int i = 0; i < allFoods.length; i++) {
      if (allFoods[i]["foodId"] == id) {
        temp = allFoods[i];
        break;
      }
    }
    setState(() {
      snack.add(temp);
    });
  }

  void addToDinnerList(String id) {
    Map<String, String> temp = {};
    for (int i = 0; i < allFoods.length; i++) {
      if (allFoods[i]["foodId"] == id) {
        temp = allFoods[i];
        break;
      }
    }
    setState(() {
      dinner.add(temp);
    });
  }

  String name = "";

  String foodId = "";
  String label = "";
  String image = "";

  TextEditingController searchController = new TextEditingController();

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

  Future<void> fetchData(setState) async {
    var headers = {
      'Cookie': 'route=48aba2948350bd216a6a69c9ffb10815',
    };
    var request = http.Request(
      'GET',
      Uri.parse(
        'https://api.edamam.com/api/food-database/v2/parser?app_id=b1956a70&app_key=d3a97a5aec29e26a6bf513f7e0b1d8b7&ingr=${searchController.text}&nutrition-type=cooking',
      ),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseBody);

      final List<dynamic> parsedFoods = data['parsed'];

      if (parsedFoods.isNotEmpty) {
        final foodData = parsedFoods[0]['food'];
        setState(() {
          foodId = foodData['foodId'];
          label = foodData['label'];
          image = foodData['image'];
        });
      } else {
        print(response.reasonPhrase);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void _showFloatingModal(BuildContext context, int option, String id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          if (option == 2) {
            return StatefulBuilder(builder: (context, StateSetter setState) {
              return AlertDialog(
                title: Text('Search Food'),
                content: SizedBox(
                  height: 200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        foodId.isNotEmpty
                            ? Text("Search Result :")
                            : SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        foodId.isNotEmpty
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: image,
                                    height: 75,
                                    width: 75,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  Text(
                                    label,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        addToFoodList();
                                      },
                                      icon: Icon(
                                        Icons.add_box,
                                        color: Colors.orange,
                                      )),
                                ],
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('Search'),
                    onPressed: () {
                      fetchData(setState);
                    },
                  ),
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
          } else {
            return AlertDialog(
                title: Text('Select Timing'),
                content: SizedBox(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            addToBreakfastList(id);
                          },
                          child: Text("Breakfast")),
                      TextButton(
                          onPressed: () {
                            addToLunchList(id);
                          },
                          child: Text("Lunch")),
                      TextButton(
                          onPressed: () {
                            addToSnacksList(id);
                          },
                          child: Text("Snacks")),
                      TextButton(
                          onPressed: () {
                            addToDinnerList(id);
                          },
                          child: Text("Dinner"))
                    ],
                  ),
                  height: 200,
                ));
          }
        });
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
                        child: Text("Set Your Meal",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Your Foods",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.02),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: getWidth(1),
                          height: getHeight(0.15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.yellow.shade300,
                          ),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < allFoods.length; i++)
                                    GestureDetector(
                                      child: Container(
                                        width: getWidth(0.3),
                                        height: getHeight(0.12),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.yellow.shade100,
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                  allFoods[i]["image"]!,
                                                  height: 60,
                                                  width: 60),
                                              SizedBox(height: 10),
                                              Text(
                                                allFoods[i]["label"]!,
                                                style: TextStyle(
                                                    color: Colors.orange),
                                              )
                                            ]),
                                      ),
                                      onTap: () {
                                        _showFloatingModal(
                                            context, 1, allFoods[i]["foodId"]!);
                                      },
                                    ),
                                  Container(
                                    width: getWidth(0.3),
                                    height: getHeight(0.12),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.yellow.shade100,
                                    ),
                                    child: Center(
                                      child: IconButton(
                                          onPressed: () {
                                            _showFloatingModal(context, 2, "");
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.orange,
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Breakfast",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.02),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: getWidth(1),
                          height: getHeight(0.15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade300,
                          ),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < breakfast.length; i++)
                                    Stack(children: [
                                      Container(
                                        width: getWidth(0.3),
                                        height: getHeight(0.12),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green.shade100,
                                        ),
                                        child: Column(children: [
                                          Image.network(breakfast[i]["image"]!,
                                              height: 60, width: 60),
                                          Text(
                                            breakfast[i]["label"]!,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        ]),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: -10,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 35,
                                              )))
                                    ]),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Lunch",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.02),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: getWidth(1),
                          height: getHeight(0.15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red.shade300,
                          ),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < lunch.length; i++)
                                    Stack(children: [
                                      Container(
                                        width: getWidth(0.3),
                                        height: getHeight(0.12),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red.shade100,
                                        ),
                                        child: Column(children: [
                                          Image.network(lunch[i]["image"]!,
                                              height: 60, width: 60),
                                          Text(
                                            lunch[i]["label"]!,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        ]),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: -10,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 35,
                                              )))
                                    ]),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Snacks",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.02),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: getWidth(1),
                          height: getHeight(0.15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.purple.shade300,
                          ),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < snack.length; i++)
                                    Stack(children: [
                                      Container(
                                        width: getWidth(0.3),
                                        height: getHeight(0.12),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.purple.shade100,
                                        ),
                                        child: Column(children: [
                                          Image.network(snack[i]["image"]!,
                                              height: 60, width: 60),
                                          Text(
                                            snack[i]["label"]!,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        ]),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: -10,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 35,
                                              )))
                                    ]),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Dinner",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.02),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: getWidth(1),
                          height: getHeight(0.15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.cyan.shade300,
                          ),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  for (int i = 0; i < dinner.length; i++)
                                    Stack(children: [
                                      Container(
                                        width: getWidth(0.3),
                                        height: getHeight(0.12),
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.cyan.shade100,
                                        ),
                                        child: Column(children: [
                                          Image.network(dinner[i]["image"]!,
                                              height: 60, width: 60),
                                          Text(
                                            dinner[i]["label"]!,
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        ]),
                                      ),
                                      Positioned(
                                          right: 0,
                                          top: -10,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                                size: 35,
                                              )))
                                    ]),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.15),
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
