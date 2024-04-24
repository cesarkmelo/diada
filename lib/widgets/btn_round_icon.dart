import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  RoundIconButton(
      {super.key,
      required this.icon,
      required this.iconSize,
      required this.onPress,
      required this.radius});

  final IconData icon;
  final VoidCallback onPress;
  final double radius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 4.0,
      constraints: BoxConstraints.tightFor(width: radius, height: radius),
      onPressed: onPress,
      shape: const CircleBorder(),
      fillColor: kPrimaryColor,
      child: Icon(
        icon,
        color: Colors.white,
        size: iconSize,
      ),
    );
  }
}
