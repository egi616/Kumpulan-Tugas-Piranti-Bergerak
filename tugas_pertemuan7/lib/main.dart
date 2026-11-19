import 'package:flutter/material.dart';
import 'package:pertemuan7/cart_model.dart';
import 'package:pertemuan7/product_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'toko pedia',
      debugShowCheckedModeBanner: false,
      home: ProductPage() ,
    );
  }
}

