import 'package:flutter/material.dart';
import 'package:pertemuan5/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  //ini construktor
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Produk',
      home: HomePage(),
    );
  }
}