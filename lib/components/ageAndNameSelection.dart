// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, file_names, sort_child_properties_last

import "package:flutter/material.dart";

class AgeAndNameSelection extends StatefulWidget {
  final Function(String, String) ageAndNameStep;

  AgeAndNameSelection({Key? key, required this.ageAndNameStep})
      : super(key: key);

  @override
  State<AgeAndNameSelection> createState() => _AgeAndNameSelectionState();
}

class _AgeAndNameSelectionState extends State<AgeAndNameSelection> {
  TextEditingController c = TextEditingController();
  TextEditingController c2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(0.2)),
            child: Text(
              "What Should We Call You?",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: getHeight(0.06),
          ),
          Container(
            margin:
                EdgeInsets.symmetric(vertical: 10, horizontal: getWidth(0.2)),
            child: TextFormField(
              controller: c,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter Your Name',
                hintStyle: TextStyle(color: Colors.grey),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: getHeight(0.1),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(0.2)),
            child: Text(
              "How Old Are You?",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: getHeight(0.06),
          ),
          Container(
            margin:
                EdgeInsets.symmetric(vertical: 10, horizontal: getWidth(0.2)),
            child: TextFormField(
              controller: c2,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter Your Age',
                hintStyle: TextStyle(color: Colors.grey),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your age';
                }
                int? age = int.tryParse(value);
                if (age == null || age < 1) {
                  return 'Please enter a valid age';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: getHeight(0.12),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.ageAndNameStep(c.text, c2.text);
              }
            },
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey.shade700,
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
