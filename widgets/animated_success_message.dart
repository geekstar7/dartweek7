import 'package:flutter/material.dart';

class AnimatedSuccessMessage extends StatefulWidget {
  const AnimatedSuccessMessage({super.key});

  @override
  State<AnimatedSuccessMessage> createState() => _AnimatedSuccessMessageState();
}

class _AnimatedSuccessMessageState extends State<AnimatedSuccessMessage> {
  double _opacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _opacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: _opacity,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Transaction Successful!',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
