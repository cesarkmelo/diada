import 'package:flutter/material.dart';

class QuestionOptBox extends StatelessWidget {
  final Widget child;

  const QuestionOptBox({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: child,
    );
  }
}
