// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final Function() openTheDrawer;
  final String name;
  const Header({Key? key, required this.openTheDrawer, required this.name})
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

    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/avatar.png",
                        height: 50,
                        width: 50,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text(
                        "Hello $name",
                        style: TextStyle(letterSpacing: 3.5),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Good Morning",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                    onPressed: () {
                      openTheDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: Colors.pink.shade800,
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
