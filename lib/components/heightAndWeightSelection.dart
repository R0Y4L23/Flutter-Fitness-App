// ignore_for_file: prefer_const_constructors_in_immutables, file_names, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import "package:flutter/material.dart";

class HeightAndWeightSelection extends StatefulWidget {
  final Function(String, String) heightAndWeightStep;

  HeightAndWeightSelection({Key? key, required this.heightAndWeightStep})
      : super(key: key);

  @override
  State<HeightAndWeightSelection> createState() =>
      _HeightAndWeightSelectionState();
}

class _HeightAndWeightSelectionState extends State<HeightAndWeightSelection> {
  TextEditingController c = TextEditingController();
  TextEditingController c2 = TextEditingController();

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

    return Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(0.2)),
        child: Text(
          "Almost There...",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        height: getHeight(0.03),
      ),
      Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "What Is Your Weight?",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: c,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'in KGs',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  )),
              Image.asset(
                "assets/weight.png",
                height: getHeight(0.23),
              )
            ],
          )),
      Container(
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/height.png",
                height: getHeight(0.23),
              ),
              Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "What Is Your Height?",
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: c2,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8),
                            hintText: 'in CMs',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  )),
            ],
          )),
      SizedBox(
        height: getHeight(0.03),
      ),
      TextButton(
        onPressed: () {
          widget.heightAndWeightStep(c2.text, c.text);
        },
        child: Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.purple,
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      )
    ]);
  }
}
