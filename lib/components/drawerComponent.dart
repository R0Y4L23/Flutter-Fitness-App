// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element, unused_import, empty_catches, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:fitness_app/screens/auth.dart';
import "package:fitness_app/screens/login.dart";
import "package:flutter/material.dart";
import "../connection/connect.dart";

class DrawerComponent extends StatelessWidget {
  const DrawerComponent({Key? key}) : super(key: key);

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

    Future<void> signOut() async {
      try {
        final response =
            await AppwriteService.account.deleteSession(sessionId: "current");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      } catch (e) {
        print('Error deleting session: ${e.toString()}');
      }
    }

    return Drawer(
      backgroundColor: Colors.pink.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/avatar.png",
                width: 120,
                height: 120,
              ),
              Column(
                children: [
                  Text(
                    "Subham Roy",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    "View Profile",
                    style: TextStyle(
                        color: Colors.grey.shade700, letterSpacing: 2),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.calculate,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "BMI Calculator",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "About Us",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  size: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Contact Us",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          TextButton(
            onPressed: () {
              signOut();
            },
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.pink.shade600,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
