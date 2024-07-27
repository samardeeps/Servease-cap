import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:servease_cap/home_screens/home.dart';
import 'package:servease_cap/splash/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Servease-Cp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splashScreen(),
    );
  }
}
