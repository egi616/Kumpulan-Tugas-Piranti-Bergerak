import 'package:flutter/material.dart';
import 'package:pertemuan3/BMIScreen.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Kalkulator BMI",
      home: BMIScreen(),
    );
  }
}