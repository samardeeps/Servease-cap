import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servease_cap/splash/splash_screen.dart';
// ignore: unused_import
import 'compare_photos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splashScreen(),
    );
  }
}
