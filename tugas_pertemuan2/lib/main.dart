import 'package:flutter/material.dart';
import 'package:tugas_pertemuan2/business_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Pertemuan 2 Kartu Nama',
      home: BusinessCard(),
    );
  }
}