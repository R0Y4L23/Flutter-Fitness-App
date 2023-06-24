// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';

class TextFieldWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final String placeholder;

  TextFieldWithIcon(
      {required this.icon, required this.label, required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  Icon(icon),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration.collapsed(
                        hintText: placeholder,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
