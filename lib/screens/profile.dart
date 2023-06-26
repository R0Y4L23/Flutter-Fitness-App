// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_element, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottomNavbar.dart';
import '../components/drawerComponent.dart';
import '../components/header.dart';
import '../components/textFieldWithIcon.dart';
import "../connection/connect.dart";

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
  String _selectedGender = "Man";

  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController caloriesController;
  late TextEditingController stepsController;

  bool isLoadingComplete = false;

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final accResponse = await AppwriteService.account.get();

    final dbResponse = await AppwriteService.databases.getDocument(
        databaseId: "6465cc04e7f8f24a9007",
        collectionId: "6465cc125d0ecc4907b9",
        documentId: prefs.getString("userID") ?? "20230615ovym");

    nameController = TextEditingController();
    ageController = TextEditingController();
    phoneController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    caloriesController = TextEditingController();
    stepsController = TextEditingController();

    try {
      setState(() {
        String username = prefs.getString('userName')!;
        name = username;

        nameController.text = dbResponse.data['name'];
        ageController.text = dbResponse.data['age'].toString();
        phoneController.text = accResponse.phone;
        _selectedGender = dbResponse.data["gender"];
        heightController.text = dbResponse.data['height'].toString();
        weightController.text = dbResponse.data['weight'].toString();

        caloriesController.text = prefs.getInt("calories").toString();
        stepsController.text = prefs.getInt("steps").toString();
      });
    } catch (e) {
      name = "User";
    }

    setState(() {
      isLoadingComplete = true;
    });
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.white,
        ),
      ),
    );
  }

  void saveCaloriesAndSteps() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("calories", int.parse(caloriesController.text));
    prefs.setInt("steps", int.parse(stepsController.text));
  }

  void updateUserData(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await AppwriteService.account.updateName(name: nameController.text);

    final entry = {
      'name': nameController.text,
      'age': int.parse(ageController.text),
      'gender': _selectedGender,
      'height': int.parse(heightController.text),
      'weight': int.parse(weightController.text),
    };

    Future result = AppwriteService.databases.updateDocument(
        databaseId: "6465cc04e7f8f24a9007",
        collectionId: "6465cc125d0ecc4907b9",
        documentId: prefs.getString("userID") ?? "20230615ovym",
        data: entry);

    result.then((response) async {
      await prefs.setString('userName', nameController.text);
      await prefs.setDouble('userWeight', double.parse(weightController.text));
      await prefs.setDouble('userHeight', double.parse(heightController.text));
      _showToast(context, "Data Successfully Updated");
    }).catchError((error) {
      _showToast(context, "Error :" + error.response);
    });
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

    if (!isLoadingComplete) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
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
                          tec: nameController,
                        ),
                        SizedBox(height: 16.0),
                        TextFieldWithIcon(
                          icon: Icons.calendar_today,
                          label: 'Age',
                          placeholder: 'Type here',
                          tec: ageController,
                        ),
                        SizedBox(height: 16.0),
                        TextFieldWithIcon(
                          icon: Icons.phone,
                          label: 'Phone',
                          placeholder: 'Type here',
                          tec: phoneController,
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
                                  EdgeInsets.only(left: 12, right: 12, top: 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: DropdownButtonFormField<String>(
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                                value: _selectedGender,
                                decoration:
                                    InputDecoration.collapsed(hintText: ''),
                                hint: Text('Gender'),
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Man',
                                    child: Text('Male'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Woman',
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
                          label: 'Height (in CMs)',
                          placeholder: 'Type here (CM)',
                          tec: heightController,
                        ),
                        SizedBox(height: 16.0),
                        TextFieldWithIcon(
                          icon: Icons.local_fire_department,
                          label: 'Weight (in KGs)',
                          placeholder: 'Type here (KG)',
                          tec: weightController,
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                updateUserData(context);
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
                          tec: caloriesController,
                        ),
                        SizedBox(height: 16.0),
                        TextFieldWithIcon(
                          icon: Icons.assist_walker,
                          label: 'Steps',
                          placeholder: 'Type here',
                          tec: stepsController,
                        ),
                        SizedBox(height: 16.0),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                saveCaloriesAndSteps();
                                _showToast(
                                    context, "Calories and Steps Updated");
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
}
