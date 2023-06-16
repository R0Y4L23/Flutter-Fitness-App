// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names, unused_element, unused_local_variable, invalid_return_type_for_catch_error, avoid_print, use_build_context_synchronously
import 'dart:math';

import 'package:fitness_app/components/ageAndNameSelection.dart';
import 'package:fitness_app/components/emailAndPasswordSelection.dart';
import 'package:fitness_app/components/genderSelection.dart';
import 'package:fitness_app/components/heightAndWeightSelection.dart';
import 'package:fitness_app/screens/dashboard.dart';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "../components/progressBar.dart";
import "../connection/connect.dart";

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

  String generateUniqueId() {
    final now = DateTime.now();
    final datePart = now.toString().substring(0, 10).replaceAll('-', '');
    final random = Random();
    final randomPart = List.generate(4, (_) => random.nextInt(26))
        .map((n) => String.fromCharCode(n + 97))
        .join();
    final uniqueId = '$datePart$randomPart';
    return uniqueId;
  }

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
        action: SnackBarAction(
          label: 'CLOSE',
          onPressed: scaffold.hideCurrentSnackBar,
          textColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<void> createUser() async {
      try {
        String uid = generateUniqueId();

        await AppwriteService.account
            .create(email: email, password: password, name: name, userId: uid);

        final entry = {
          'uid': uid,
          'name': name,
          'email': email,
          'gender': gender,
          'age': age,
          'height': height2,
          'weight': weight,
        };

        final dbResponse = await AppwriteService.databases.createDocument(
            databaseId: '6465cc04e7f8f24a9007',
            collectionId: '6465cc125d0ecc4907b9',
            data: entry,
            documentId: uid);

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userData', dbResponse.data.toString());
        await prefs.setString('userName', dbResponse.data['name']);
        await prefs.setDouble('userWeight', dbResponse.data['weight']);
        await prefs.setDouble('userHeight', dbResponse.data['height']);

        await AppwriteService.account.createEmailSession(
          email: email,
          password: password,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } catch (e) {
        print(e.toString());
        _showToast(context, e.toString());
      }
    }

    void emailAndPasswordStep(e, p) {
      setState(() {
        email = e;
        password = p;
      });
      createUser();
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
        body: Stack(
      children: [
        Container(
          color: Color.fromARGB(255, 24, 24, 24),
          width: double.infinity,
          height: double.infinity,
        ),
        SingleChildScrollView(
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
      ],
    ));
  }
}
