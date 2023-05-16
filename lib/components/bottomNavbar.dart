// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, unused_element

import 'package:fitness_app/screens/mealPlanner.dart';
import "package:flutter/material.dart";

import '../screens/dashboard.dart';

class BottomNavbar extends StatelessWidget {
  final int indexOfThisScreen;

  const BottomNavbar({Key? key, required this.indexOfThisScreen})
      : super(key: key);

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

    return Positioned(
        bottom: 1.0,
        left: 0,
        right: 0,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                currentIndex: indexOfThisScreen,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.food_bank),
                    label: 'Meal Planner',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart),
                    label: 'Nutrients Chart',
                  ),
                ],
                onTap: (index) {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MealPlanner()),
                    );
                  } else if (index == 2) {}
                },
                backgroundColor: Colors.blue.shade100,
              ),
            )));
  }
}
