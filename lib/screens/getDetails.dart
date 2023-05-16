// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, unused_element

import 'package:fitness_app/components/ageAndNameSelection.dart';
import 'package:fitness_app/components/emailAndPasswordSelection.dart';
import 'package:fitness_app/components/genderSelection.dart';
import 'package:fitness_app/components/heightAndWeightSelection.dart';
import 'package:fitness_app/screens/dashboard.dart';
import "package:flutter/material.dart";
import "../components/progressBar.dart";

class GetDetails extends StatefulWidget {
  GetDetails({Key? key}) : super(key: key);

  @override
  State<GetDetails> createState() => _GetDetailsState();
}

class _GetDetailsState extends State<GetDetails> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  int step = 1;

  String gender = "";

  String name = "";
  String age = "";

  String height2 = "";
  String weight = "";

  String email = "";
  String password = "";

  void genderStep(g) {
    setState(() {
      step++;
      gender = g;
    });
  }

  void ageAndNameStep(n, a) {
    setState(() {
      step++;
      name = n;
      age = a;
    });
  }

  void heightAndWeightStep(he, we) {
    setState(() {
      step++;
      weight = we;
      height2 = he;
    });
  }

  @override
  Widget build(BuildContext context) {
    void emailAndPasswordStep(e, p) {
      setState(() {
        email = e;
        password = p;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      });
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double getHeight(h) {
      return height * h;
    }

    double getWidth(w) {
      return width * w;
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: getHeight(0.1),
          ),
          Center(
            child: ProgressBar(
              step: step,
              total: 4,
            ),
          ),
          SizedBox(height: getHeight(0.06)),
          step == 1
              ? GenderSelection(genderStep: genderStep)
              : step == 2
                  ? AgeAndNameSelection(
                      ageAndNameStep: ageAndNameStep,
                    )
                  : step == 3
                      ? HeightAndWeightSelection(
                          heightAndWeightStep: heightAndWeightStep,
                        )
                      : EmailAndPasswordSelection(
                          emailAndPasswordStep: emailAndPasswordStep)
        ],
      )),
    );
  }
}
