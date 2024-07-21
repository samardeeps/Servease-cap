import 'package:flutter/material.dart';
import 'package:animated_check/animated_check.dart';

class AnimatedTick extends StatefulWidget {
  @override
  _AnimatedTickState createState() => _AnimatedTickState();
}

class _AnimatedTickState extends State<AnimatedTick>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController?.forward();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedCheck(
        progress: _animationController!,
        size: 100,
        color: Colors.green,
      ),
    );
  }
}
