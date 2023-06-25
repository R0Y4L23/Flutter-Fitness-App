// ignore_for_file: prefer_const_constructors_in_immutables, unused_element, prefer_const_constructors, file_names, prefer_final_fields, avoid_print, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import "dart:convert";

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:http/http.dart' as http;

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
  List<Map<String, dynamic>> searchResults = [];

  Map<String, dynamic> currentFood = {};

  TextEditingController _textEditingController = TextEditingController();

  Future<void> searchRecipe() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.edamam.com/api/recipes/v2?type=public&q=${_textEditingController.text}&app_id=456f6ff6&app_key=19130d8651ffb9f19410b312fe4392a5'));
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseBody);
      List<Map<String, dynamic>> temp = [];
      for (int i = 0; i < data["hits"].length; i++) {
        temp.add({
          "label": data["hits"][i]["recipe"]["label"],
          "image": data["hits"][i]["recipe"]["image"],
          "cuisine": data["hits"][i]["recipe"]["cuisineType"][0],
          "mealType": data["hits"][i]["recipe"]["mealType"][0],
          "energy": data["hits"][i]["recipe"]["totalNutrients"]["ENERC_KCAL"],
          "carbohydrates": data["hits"][i]["recipe"]["totalNutrients"]
              ["CHOCDF.net"],
          "protein": data["hits"][i]["recipe"]["totalNutrients"]["PROCNT"],
          "fat": data["hits"][i]["recipe"]["totalNutrients"]["FAT"],
          "sugar": data["hits"][i]["recipe"]["totalNutrients"]["SUGAR"],
          "cholesterol": data["hits"][i]["recipe"]["totalNutrients"]["CHOLE"],
          "water": data["hits"][i]["recipe"]["totalNutrients"]["WATER"]
        });
      }
      setState(() {
        searchResults = temp;
      });
    } else {
      print(response.reasonPhrase);
    }
  }

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

  void _showFloatingModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Details about ${currentFood["label"]!}:'),
            content: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      currentFood["image"]!,
                      height: 225,
                      width: 225,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentFood["cuisine"].toUpperCase(),
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        Text(currentFood["mealType"])
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Total Nutrients:",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${"Energy: " + currentFood["energy"]["quantity"].toStringAsFixed(2)} " +
                          currentFood["energy"]["unit"],
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${"Carbohydrates: " + currentFood["carbohydrates"]["quantity"].toStringAsFixed(2)} " +
                          currentFood["carbohydrates"]["unit"],
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${"Protein: " + currentFood["protein"]["quantity"].toStringAsFixed(2)} " +
                          currentFood["protein"]["unit"],
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${"Fat: " + currentFood["fat"]["quantity"].toStringAsFixed(2)} " +
                          currentFood["fat"]["unit"],
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${"Sugar: " + currentFood["sugar"]["quantity"].toStringAsFixed(2)} " +
                          currentFood["sugar"]["unit"],
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${"Cholesterol: " + currentFood["cholesterol"]["quantity"].toStringAsFixed(2)} " +
                          currentFood["cholesterol"]["unit"],
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "${"Water: " + currentFood["water"]["quantity"].toStringAsFixed(2)} " +
                          currentFood["water"]["unit"],
                      style: TextStyle(fontSize: 15),
                    )),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
            actions: [
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
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
                        child: Text("Nutrients Chart",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                decoration: InputDecoration(
                                  hintText: 'Enter a food or recipe',
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: searchRecipe,
                              child: Text('Search'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      for (int i = 0; i < searchResults.length; i++)
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                currentFood = searchResults[i];
                              });
                              _showFloatingModal(context);
                            },
                            leading:
                                SizedBox(width: 20, child: Text("${i + 1}.")),
                            title: SizedBox(
                                width: 20,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    searchResults[i]["image"]!,
                                    height: 80,
                                    width: 80,
                                  ),
                                )),
                            trailing: SizedBox(
                                width: 200,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    searchResults[i]["label"]!,
                                    style: TextStyle(fontSize: 16),
                                  ),
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
              BottomNavbar(indexOfThisScreen: 2)
            ],
          ),
        ));
  }
}
