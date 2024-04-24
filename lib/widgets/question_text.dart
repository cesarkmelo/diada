import 'package:flutter/material.dart';

import '../utils/constants.dart';

class QuestionText extends StatelessWidget {
  final String qText;
  const QuestionText({required this.qText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Text(
        qText,
        textAlign: TextAlign.center,
        style: kQuestionTextStyle,
      ),
    );
  }
}
