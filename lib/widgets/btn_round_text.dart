import 'package:flutter/material.dart';

class RoundTextButton extends StatelessWidget {
  const RoundTextButton({
    super.key,
    required this.text,
    required this.onPress,
    required this.color,
  });

  final String text;
  final VoidCallback onPress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        backgroundColor: color,
        shape: const StadiumBorder(),
      ),
      onPressed: onPress,
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
