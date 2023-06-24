// ignore_for_file: prefer_const_constructors, unused_element, prefer_const_constructors_in_immutables, file_names, use_key_in_widget_constructors

import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../components/bottomNavbar.dart";
import "../components/drawerComponent.dart";
import "../components/header.dart";

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openTheDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  String name = "";

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      setState(() {
        String username = prefs.getString('userName')!;
        name = username;
      });
    } catch (e) {
      name = "User";
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

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
        key: _scaffoldKey,
        endDrawer: DrawerComponent(
          name: name,
        ),
        body: SizedBox(
          height: getHeight(0.98),
          child: Stack(
            children: [
              Positioned(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(
                        openTheDrawer: openTheDrawer,
                        name: name,
                      ),
                      SizedBox(
                        height: getHeight(0.05),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text("About Us",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(
                        height: getHeight(0.02),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome to our Fitness App! We are passionate about helping you achieve your health and fitness goals. Our app combines a range of useful features designed to support you on your wellness journey. Let us introduce you to the key components of our app:',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 16.0),
                            FeatureItem(
                              number: '1',
                              title: 'Steps Tracker',
                              description:
                                  'Stay motivated and track your daily steps. Our app utilizes the sensors in your device to count your steps, helping you monitor your activity level and progress towards a more active lifestyle.',
                            ),
                            FeatureItem(
                              number: '2',
                              title: 'Calorie Tracker',
                              description:
                                  'Achieving your fitness goals often involves managing your calorie intake. Our app provides a comprehensive calorie tracker, allowing you to log your meals and snacks, and monitor your daily calorie consumption. This tool assists you in making informed choices and maintaining a balanced diet.',
                            ),
                            FeatureItem(
                              number: '3',
                              title: 'Meal Planner',
                              description:
                                  'Eating right is essential for optimal health and fitness. Our meal planner feature offers a wide range of nutritious meal options, customizable to your dietary preferences and requirements. Plan your meals in advance and ensure you\'re fueling your body with the right nutrients.',
                            ),
                            FeatureItem(
                              number: '4',
                              title: 'Nutrients Chart',
                              description:
                                  'Learn about the nutritional content of various foods with our nutrients chart. Get detailed information on vitamins, minerals, and macronutrients, empowering you to make educated choices when it comes to your diet.',
                            ),
                            FeatureItem(
                              number: '5',
                              title: 'BMI Calculator',
                              description:
                                  'Our app includes a BMI (Body Mass Index) calculator, enabling you to assess your overall body composition. Simply enter your height and weight, and our app will provide you with your BMI value, helping you monitor your progress towards a healthy weight.',
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'We are committed to providing you with a user-friendly and effective fitness app. Our goal is to support you in leading a healthier lifestyle by making fitness and nutrition accessible and enjoyable.',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Please note that while our app provides valuable tools and information, it is always recommended to consult with healthcare professionals or certified trainers for personalized advice and guidance.',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Thank you for choosing our Fitness App. We hope you find it beneficial and that it helps you reach your fitness goals. Stay motivated, stay active, and enjoy your journey to a healthier you!',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: getHeight(0.12)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              BottomNavbar(indexOfThisScreen: 1)
            ],
          ),
        ));
  }
}

class FeatureItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  FeatureItem(
      {required this.number, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. $title',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
