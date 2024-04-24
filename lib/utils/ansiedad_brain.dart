import '../classes/question.dart';

class AnsiedadBrain {
  int _questionNumber = 0;
  final List<Question> _questionsList = [
    Question(
      label:
          'Durante los últimos 15 días, ¿con qué frecuencia ha sentido molestias por el siguiente problema?',
      questionText:
          'Sentirse nervioso, ansioso, notar que se le ponen los nervios de punta',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Varios días',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'La mitad de los días',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Casi todos los días',
            answerState: false,
            answerValue: 3),
      ],
    ),
    Question(
      label:
          'Durante los últimos 15 días, ¿con qué frecuencia ha sentido molestias por el siguiente problema?',
      questionText: 'No ser capaz de parar o controlar sus preocupaciones',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Varios días',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'La mitad de los días',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Casi todos los días',
            answerState: false,
            answerValue: 3),
      ],
    ),
    Question(
      label:
          'Durante los últimos 15 días, ¿con qué frecuencia ha sentido molestias por el siguiente problema?',
      questionText: 'Preocuparse demasiado sobre diferentes cosas',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Varios días',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'La mitad de los días',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Casi todos los días',
            answerState: false,
            answerValue: 3),
      ],
    ),
    Question(
      label:
          'Durante los últimos 15 días, ¿con qué frecuencia ha sentido molestias por el siguiente problema?',
      questionText: 'Dificultad para relajarse',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Varios días',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'La mitad de los días',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Casi todos los días',
            answerState: false,
            answerValue: 3),
      ],
    ),
    Question(
      label:
          'Durante los últimos 15 días, ¿con qué frecuencia ha sentido molestias por el siguiente problema?',
      questionText:
          'Estar tan desasosegado que le resulta difícil parar y quedarse quieto',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Varios días',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'La mitad de los días',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Casi todos los días',
            answerState: false,
            answerValue: 3),
      ],
    ),
    Question(
      label:
          'Durante los últimos 15 días, ¿con qué frecuencia ha sentido molestias por el siguiente problema?',
      questionText: 'Sentirse fácilmente disgustado o irritable',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Varios días',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'La mitad de los días',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Casi todos los días',
            answerState: false,
            answerValue: 3),
      ],
    ),
    Question(
      label:
          'Durante los últimos 15 días, ¿con qué frecuencia ha sentido molestias por el siguiente problema?',
      questionText: 'Sentirse asustado como si algo horrible pudiese pasar',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Varios días',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'La mitad de los días',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Casi todos los días',
            answerState: false,
            answerValue: 3),
      ],
    ),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionsList.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionsList[_questionNumber].questionText;
  }

  String? getQuestionLabel() {
    return _questionsList[_questionNumber].label;
  }

  bool hasQuestionLabel() {
    return _questionsList[_questionNumber].label != null ? true : false;
  }

  int getQuestionsLength() {
    return _questionsList.length;
  }

  int getQuestionsIndex() {
    return _questionNumber + 1;
  }

  List<Answer> getQuestionAnswersList() {
    print('Questionnumber GetQuestionAnswerList $_questionNumber');
    return _questionsList[_questionNumber].questionAnswers;
  }

  bool isFinished() {
    if (_questionNumber == _questionsList.length - 1) {
      //print('Estoy al final del examen se debe reiniciar y guardar resultado');
      return true;
    } else {
      return false;
    }
  }

  bool filterTest(sumFirst2) {
    if (_questionNumber < 1) {
      return true;
    } else {
      if (sumFirst2 > 3) {
        return true;
      } else {
        return false;
      }
    }
  }

  String getResultGad7(int value) {
    if (value <= 4) {
      return "Sin trastorno de ansiedad";
    } else if (value <= 9) {
      return "Trastorno de ansiedad leve";
    } else if (value <= 14) {
      return "Trastorno de ansiedad moderada";
    } else {
      return "Trastorno de ansiedad grave";
    }
  }

  String getRecomendationsGad7(int value) {
    if (value <= 4) {
      return "Recuerde mantener hábitos de vida saludables para mantener buena salud mental: Practique actividades de autocuidado, alimentación balanceada y con todos los grupos de alimentos, actividad física diarios y suficiente sueño.";
    } else if (value <= 10) {
      return "Es importante recuperar los hábitos y estilos de vida saludable para recuperar su bienestar, tranquilidad y salud mental. Recuerde practicar actividades de autocuidado (participar en actividades que lo ayuden a sentir mejor, reducir el estrés, limitar consumo de alcohol), tener una buena alimentación, actividad física diaria, suficiente sueño y practicar técnicas de relajación (puede repetir palabras en la mente, imaginar un ambiente tranquilo, visualizar imágenes que lo lleguen a un lugar que le genere bienestar).";
    } else if (value <= 15) {
      return "Es importante recuperar los hábitos y estilos de vida saludable para recuperar su bienestar, tranquilidad y salud mental. Recuerde practicar actividades de autocuidado (participar en actividades que lo ayuden a sentir mejor, reducir el estrés, limitar consumo de alcohol), tener una buena alimentación, actividad física diaria, suficiente sueño y practicar técnicas de relajación (puede repetir palabras en la mente, imaginar un ambiente tranquilo, visualizar imágenes que lo lleguen a un lugar que le genere bienestar). Considere consultar a su médico, quien puede realizar un diagnóstico y brindarle alternativas para reducir sus síntomas.";
    } else {
      return "Sus síntomas de ansiedad pueden estar afectando su salud, tranquilidad y calidad de vida de una forma significativa. pueden estar afectando su bienestar, tranquilidad y su salud mental. Recomendamos consultar a su médico, quien puede realizar un diagnóstico y brindarle alternativas para reducir sus síntomas. Considere practicar actividades de autocuidado (participar en actividades que lo ayuden a sentir mejor, reducir el estrés, limitar consumo de alcohol, pasatiempos, socializar, salir a caminar, fortalecer red de apoyo), tener una buena alimentación, actividad física diaria, suficiente sueño y practicar técnicas de relajación (puede repetir palabras en la mente, imaginar un ambiente tranquilo, visualizar imágenes que lo lleguen a un lugar que le genere bienestar). Recomendamos consultar a su médico, quien puede realizar un diagnóstico y brindarle alternativas para reducir sus síntomas. ";
    }
  }

  void setAnswerValue(question, answer) {
    int questionIndex = question - 1;
    for (var element in _questionsList[questionIndex].questionAnswers) {
      element.answerState = false;
    }
    _questionsList[questionIndex].questionAnswers[answer].answerState = true;
  }

  int getAnswerValue(question, answer) {
    int questionIndex = question - 1;
    return _questionsList[questionIndex].questionAnswers[answer].answerValue;
  }

  void reset() {
    _questionNumber = 0;
    for (var question in _questionsList) {
      for (var element in question.questionAnswers) {
        element.answerState = false;
      }
    }
    print('Reset QuestionNumber $_questionNumber');
  }
}
