// ignore_for_file: prefer_const_constructors_in_immutables, unused_local_variable, prefer_const_literals_to_create_immutables, unused_element, prefer_const_constructors, sort_child_properties_last, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import "./getDetails.dart";
import "./login.dart";

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
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
        body: Stack(
      children: [
        Image.asset(
          "assets/fitness.png",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Container(
          color: Colors.black.withOpacity(0.7),
          width: double.infinity,
          height: double.infinity,
        ),
        Column(
          children: [
            SizedBox(
              height: getHeight(0.25),
            ),
            Text(
              "Welcome To Fitness App",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: getHeight(0.05),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(0.1)),
              child: Text(
                "Transform Your Body, Transform Your Life",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: getHeight(0.05),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GetDetails()),
                );
              },
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: EdgeInsets.symmetric(
                    horizontal: getWidth(0.05), vertical: getHeight(0.02)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(0.1),
            ),
            RichText(
              text: TextSpan(
                text: 'Already have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                ),
                children: [
                  TextSpan(
                    text: 'Login',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }
}
