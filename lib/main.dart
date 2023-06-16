import 'package:fitness_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'screens/auth.dart';
import "package:shared_preferences/shared_preferences.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        String username = prefs.getString('userName')!;
        name = username;
      });
    } catch (e) {
      name = "";
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      home: name.isNotEmpty ? Dashboard() : Auth(),
      debugShowCheckedModeBanner: false,
    );
  }
}
