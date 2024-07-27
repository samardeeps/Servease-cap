import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:servease_cap/home_screens/home.dart';
import 'package:servease_cap/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCGtSpqY0-aG5zS9kgJR2Z6FQVN5dtUBz8",
            authDomain: "demo1-2060d.firebaseapp.com",
            projectId: "demo1-2060d",
            storageBucket: "demo1-2060d.appspot.com",
            messagingSenderId: "184524377173",
            appId: "1:184524377173:android:90b3eec1e30a9d31ff98dc"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Servease-Cap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splashScreen(),
    );
  }
}
