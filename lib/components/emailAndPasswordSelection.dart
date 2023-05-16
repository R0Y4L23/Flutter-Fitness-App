// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, sort_child_properties_last

import "package:flutter/material.dart";

class EmailAndPasswordSelection extends StatefulWidget {
  final Function(String, String) emailAndPasswordStep;

  EmailAndPasswordSelection({Key? key, required this.emailAndPasswordStep})
      : super(key: key);

  @override
  State<EmailAndPasswordSelection> createState() =>
      _EmailAndPasswordSelectionState();
}

class _EmailAndPasswordSelectionState extends State<EmailAndPasswordSelection> {
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
          "Where Can We Contact You?",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        height: getHeight(0.06),
      ),
      Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: getWidth(0.2)),
          child: TextField(
            controller: c,
            decoration: InputDecoration(
              hintText: 'Enter Your Email',
              hintStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          )),
      SizedBox(
        height: getHeight(0.1),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: getWidth(0.2)),
        child: Text(
          "Your Secrets are safe with us.",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
      ),
      SizedBox(
        height: getHeight(0.06),
      ),
      Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: getWidth(0.2)),
          child: TextField(
            controller: c2,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter Your Password',
              hintStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          )),
      SizedBox(
        height: getHeight(0.12),
      ),
      TextButton(
        onPressed: () {
          widget.emailAndPasswordStep(c.text, c2.text);
        },
        child: Text(
          'Finish',
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
