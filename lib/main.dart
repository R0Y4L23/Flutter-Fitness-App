// ignore_for_file: prefer_const_constructors

import 'package:fitness_app/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/auth.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:awesome_notifications/awesome_notifications.dart';

import 'connection/notification.dart';

Future<void> getActivityPermission() async {
  if (!await Permission.activityRecognition.status.isGranted) {
    await Permission.activityRecognition.request();
  }
}

void main() {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  runApp(const MyApp());
  getActivityPermission();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name = "";

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("steps") == null) {
      prefs.setInt("steps", 8000);
    }
    if (prefs.getInt("calories") == null) {
      prefs.setInt("calories", 800);
    }

    try {
      setState(() {
        String username = prefs.getString('userName')!;
        name = username;
      });
    } catch (e) {
      name = "";
    }
  }

  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      home: name.isNotEmpty ? Dashboard() : Auth(),
      debugShowCheckedModeBanner: false,
    );
  }
}
