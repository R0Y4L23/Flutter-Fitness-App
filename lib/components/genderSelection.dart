// ignore_for_file: file_names, prefer_const_constructors, unnecessary_import, prefer_typing_uninitialized_variables

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

class GenderSelection extends StatelessWidget {
  final Function(String) genderStep;

  const GenderSelection({Key? key, required this.genderStep}) : super(key: key);

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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getWidth(0.2)),
          child: Text(
            "Lets Us Know Who You Are?",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: getHeight(0.06),
        ),
        Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        genderStep("Man");
                      },
                      child: Text(
                        'Man',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                    )),
                Image.asset(
                  "assets/man.png",
                  height: getHeight(0.23),
                )
              ],
            )),
        Container(
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/woman.png",
                  height: getHeight(0.23),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        genderStep("Woman");
                      },
                      child: Text(
                        'Woman',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 20,
                        ),
                      ),
                    )),
              ],
            ))
      ],
    );
  }
}
