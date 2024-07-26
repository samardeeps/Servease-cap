import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servease_cap/splash/animated-check.dart';
import 'package:servease_cap/home_screens/home.dart';

class VerificationCompleteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to Home page after a delay
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(Home());
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTick(),
            const SizedBox(height: 20),
            const Text(
              "Verification Completed",
              style: TextStyle(
                color: Colors.green,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
