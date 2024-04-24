class Answer {
  String label;
  String answerText;
  bool answerState;
  int answerValue;

  Answer(
      {required this.label,
      required this.answerText,
      required this.answerState,
      required this.answerValue});
}

class Question {
  String? label;
  String questionText;
  List<Answer> questionAnswers;
  bool? info;

  Question(
      {required this.questionText,
      required this.questionAnswers,
      this.label,
      this.info});
}
