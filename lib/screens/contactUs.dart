// ignore_for_file: prefer_const_constructors, unused_element, prefer_const_constructors_in_immutables, file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/bottomNavbar.dart';
import '../components/drawerComponent.dart';
import '../components/header.dart';

class ContactUs extends StatefulWidget {
  ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

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

  void _submitForm() {
    // Retrieve the form values and handle the submission
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String subject = _subjectController.text;
    final String message = _messageController.text;

    // Perform your submission logic here

    // Clear the form fields after submission
    _nameController.clear();
    _emailController.clear();
    _subjectController.clear();
    _messageController.clear();

    // Show a success dialog or navigate to a success screen
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your message has been submitted successfully.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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
                        child: Text("Contact Us",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.03),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(labelText: 'Name'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(labelText: 'Email'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  // You can add additional email validation logic here
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _subjectController,
                                decoration:
                                    InputDecoration(labelText: 'Subject'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter the subject';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16.0),
                              TextFormField(
                                controller: _messageController,
                                decoration:
                                    InputDecoration(labelText: 'Message'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your message';
                                  }
                                  return null;
                                },
                                maxLines: 4,
                              ),
                              SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Perform submission logic
                                    _submitForm();
                                  }
                                },
                                child: Text('Submit'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getHeight(0.05),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Our Email",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.02),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("Test@gmail.com",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500)),
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
