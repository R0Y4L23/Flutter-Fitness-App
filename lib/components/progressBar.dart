// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, file_names, unused_element

import "package:flutter/material.dart";

class ProgressBar extends StatelessWidget {
  final int total;
  final int step;

  ProgressBar({required this.total, required this.step});

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

    double progress = step / total;

    return Column(
      children: [
        Container(
          height: 5,
          width: getWidth(0.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Container(
                height: 5,
                width: progress * MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Step $step/$total',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }
}
