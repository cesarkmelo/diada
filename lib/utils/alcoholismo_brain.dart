import 'package:diada/classes/question.dart';

class AlcoholismoBrain {
  int _questionNumber = 0;
  List<Question> _questionsList = [
    Question(
        questionText:
            '¿Con qué frecuencia consume alguna bebida alcohólica (trago)?',
        questionAnswers: [
          Answer(
              label: 'A',
              answerText: 'Nunca',
              answerState: false,
              answerValue: 0),
          Answer(
              label: 'B',
              answerText: 'Una o menos veces al mes',
              answerState: false,
              answerValue: 1),
          Answer(
              label: 'C',
              answerText: 'De 2 a 3 veces al mes',
              answerState: false,
              answerValue: 2),
          Answer(
              label: 'D',
              answerText: 'De 2 a 3 veces al la semana',
              answerState: false,
              answerValue: 3),
          Answer(
              label: 'E',
              answerText: '4 o mas veces a la semana',
              answerState: false,
              answerValue: 4),
        ],
        info: true),
    Question(
        questionText:
            '¿Cuántos tragos (de bebidas alcohólicas) suele tomar en un día de consumo?',
        questionAnswers: [
          Answer(
              label: 'A',
              answerText: '1 o 2',
              answerState: false,
              answerValue: 0),
          Answer(
              label: 'B',
              answerText: '3 o 4',
              answerState: false,
              answerValue: 1),
          Answer(
              label: 'C',
              answerText: '5 o 6',
              answerState: false,
              answerValue: 2),
          Answer(
              label: 'D',
              answerText: '7 a 9',
              answerState: false,
              answerValue: 3),
          Answer(
              label: 'E',
              answerText: '10 o más',
              answerState: false,
              answerValue: 4),
        ],
        info: true),
    Question(
        questionText:
            '¿Con qué frecuencia toma 6 o más tragos (bebidas alcohólicas) en un solo día de consumo?',
        questionAnswers: [
          Answer(
              label: 'A',
              answerText: 'Nunca',
              answerState: false,
              answerValue: 0),
          Answer(
              label: 'B',
              answerText: 'Menos de una vez al mes',
              answerState: false,
              answerValue: 1),
          Answer(
              label: 'C',
              answerText: 'Mensualmente',
              answerState: false,
              answerValue: 2),
          Answer(
              label: 'D',
              answerText: 'Semanalmente',
              answerState: false,
              answerValue: 3),
          Answer(
              label: 'E',
              answerText: 'A diario o casi a diario',
              answerState: false,
              answerValue: 4),
        ],
        info: true),
    Question(
      questionText:
          '¿Con qué frecuencia, en el curso del último año, no ha podido parar de beber una vez había empezado?',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Menos de una vez al mes',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'Mensualmente',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Semanalmente',
            answerState: false,
            answerValue: 3),
        Answer(
            label: 'E',
            answerText: 'A diario o casi a diario',
            answerState: false,
            answerValue: 4),
      ],
    ),
    Question(
      questionText:
          '¿Con qué frecuencia, en el curso del último año, no pudo hacer lo que se esperaba de usted laboral, familiar o socialmente, porque había bebido?',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Menos de una vez al mes',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'Mensualmente',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Semanalmente',
            answerState: false,
            answerValue: 3),
        Answer(
            label: 'E',
            answerText: 'A diario o casi a diario',
            answerState: false,
            answerValue: 4),
      ],
    ),
    Question(
      questionText:
          '¿Con qué frecuencia, en el curso del último año, ha necesitado beber en ayunas para recuperarse después de haber bebido mucho en el día anterior?',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Menos de una vez al mes',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'Mensualmente',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Semanalmente',
            answerState: false,
            answerValue: 3),
        Answer(
            label: 'E',
            answerText: 'A diario o casi a diario',
            answerState: false,
            answerValue: 4),
      ],
    ),
    Question(
      questionText:
          '¿Con qué frecuencia, en el curso del último año, ha sentido remordimiento o culpa después de haber bebido?',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Menos de una vez al mes',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'Mensualmente',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Semanalmente',
            answerState: false,
            answerValue: 3),
        Answer(
            label: 'E',
            answerText: 'A diario o casi a diario',
            answerState: false,
            answerValue: 4),
      ],
    ),
    Question(
      questionText:
          '¿Con qué frecuencia, en el curso del último año, no ha podido recordar lo que sucedió la noche anterior porque había estado bebiendo?',
      questionAnswers: [
        Answer(
            label: 'A',
            answerText: 'Nunca',
            answerState: false,
            answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Menos de una vez al mes',
            answerState: false,
            answerValue: 1),
        Answer(
            label: 'C',
            answerText: 'Mensualmente',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'D',
            answerText: 'Semanalmente',
            answerState: false,
            answerValue: 3),
        Answer(
            label: 'E',
            answerText: 'A diario o casi a diario',
            answerState: false,
            answerValue: 4),
      ],
    ),
    Question(
      questionText:
          '¿Usted o alguna otra persona ha resultado herida porque usted había bebido alcohol?',
      questionAnswers: [
        Answer(
            label: 'A', answerText: 'No', answerState: false, answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Sí, pero no en el curso del último año ',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'C',
            answerText: 'Si, en el último año',
            answerState: false,
            answerValue: 4),
      ],
    ),
    Question(
      questionText:
          '¿Algún familiar, amigo, médico o profesional de la salud ha mostrado preocupación por su consumo de bebidas alcohólicas o le ha sugerido que deje de beber?',
      questionAnswers: [
        Answer(
            label: 'A', answerText: 'No', answerState: false, answerValue: 0),
        Answer(
            label: 'B',
            answerText: 'Sí, pero no en el último año',
            answerState: false,
            answerValue: 2),
        Answer(
            label: 'C',
            answerText: 'Si, en el último año',
            answerState: false,
            answerValue: 4),
      ],
    ),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionsList.length - 1) {
      _questionNumber++;
    }
  }

  bool filterTest(sumFirst3) {
    if (_questionNumber < 2) {
      return true;
    } else {
      if (sumFirst3 > 0) {
        return true;
      } else {
        return false;
      }
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

  bool hasQuestionInfo() {
    return _questionsList[_questionNumber].info != null ? true : false;
  }

  int getQuestionsLength() {
    return _questionsList.length;
  }

  int getQuestionsIndex() {
    return _questionNumber + 1;
  }

  List<Answer> getQuestionAnswersList() {
    return _questionsList[_questionNumber].questionAnswers;
  }

  bool isFinished() {
    if (_questionNumber == _questionsList.length - 1) {
      print('Estoy al final del examen se debe reiniciar y guardar resultado');
      return true;
    } else {
      return false;
    }
  }

  String getResultAudit(int value, Future<bool> Function() isMale) {
    int limit1 = 5;
    if (isMale == true) {
      limit1 = limit1 + 2;
    }
    if (value <= limit1) {
      return "Consumo no riesgoso de alcohol";
    } else if (value <= 19) {
      return "Consumo riesgoso de alcohol";
    } else {
      return "Posible dependencia al alcohol";
    }
  }

  String getRecomendationsAudit(int value, Future<bool> Function() isMale) {
    int limit1 = 5;
    if (isMale == true) {
      limit1 = limit1 + 2;
    }
    if (value <= limit1) {
      return "Felicitaciones. Su patrón de consumo de alcohol es de bajo riesgo.\nSiga por este camino y recuerde mantener hábitos de vida saludables para mantener una buena salud mental.\nPractique actividades de autocuidado, alimentación saludable, actividad física diaria, suficiente sueño.";
    } else if (value <= 19) {
      return "Su patrón de consumo de alcohol está relacionado con algunos riesgos y puede estar afectando su salud.\nRecomendamos consultar a su médico, quien le explicará el impacto que puede tener en su salud y le ayudará a identificar alternativas para reducir el riesgo.\nPractique actividades de autocuidado, alimentación saludable, actividad física diaria, y suficiente sueño.";
    } else {
      return "Su patrón de consumo de alcohol está asociado a problemas graves en la salud física y mental.\nConsulte a su médico, quien le explicará cómo su consumo de alcohol puede afectar su salud y le ayudará a identificar alternativas para reducir el riesgo.\nPractique actividades de autocuidado, alimentación saludable, actividad física diaria, y suficiente sueño.";
    }
  }

  void setAnswerState(question, answer) {
    int questionIndex = question - 1;
    _questionsList[questionIndex].questionAnswers.forEach((element) {
      element.answerState = false;
    });
    _questionsList[questionIndex].questionAnswers[answer].answerState = true;
  }

  int getAnswerValue(question, answer) {
    int questionIndex = question - 1;
    return _questionsList[questionIndex].questionAnswers[answer].answerValue;
  }

  void reset() {
    _questionsList.forEach((question) {
      question.questionAnswers.forEach((element) {
        element.answerState = false;
      });
    });
    _questionNumber = 0;
  }
}
