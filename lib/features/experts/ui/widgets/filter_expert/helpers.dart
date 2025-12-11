import 'package:flutter/material.dart';

Widget sectionTitle(String title) => Padding(
  padding: const EdgeInsets.only(bottom: 8),
  child: Text(
    title,
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
  ),
);

String dayName(int weekday) => [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
][weekday - 1];
