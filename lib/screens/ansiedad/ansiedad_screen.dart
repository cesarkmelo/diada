import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../classes/question.dart';
import '../../providers/resultados_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/diada_api.dart';
import '../../utils/ansiedad_brain.dart';
import '../../utils/constants.dart';
import '../../widgets/question_text.dart';
import '../resultados/resultados_screen.dart';

//Creo el nuevo objeto brain
AnsiedadBrain ansiedadBrain = AnsiedadBrain();

class AnsiedadScreen extends StatefulWidget {
  static const String id = 'ansiedad_screen';
  @override
  _AnsiedadScreenState createState() => _AnsiedadScreenState();
}

class _AnsiedadScreenState extends State<AnsiedadScreen> {
  bool answered = false;
  int result = 0;
  Map<int, int> respuestasAns = {1: 0, 2: 0};

  @override
  void initState() {
    ansiedadBrain.reset();
    super.initState();
  }

  void checkAnswer() {
    print('En check Answer ${ansiedadBrain.getQuestionsIndex()}');
    if (answered == true) {
      setState(() {
        if (ansiedadBrain.isFinished() == true) {
          // Termino encuesta: Guarda resultados y pasa al siguiente paso
          var values = respuestasAns.values;
          var result = values.reduce((sum, element) => sum + element);
          context.read<Resultados>().setAnsiedad(result);
          storeAnsiedad(result);
          ansiedadBrain.reset();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('resultados_screen', (route) => false);
        } else {
          // Continua con la siguiente pregunta
          var sum = respuestasAns[1]! + respuestasAns[2]!;
          // Envio la suma de los 2 primeros para filtar
          if (ansiedadBrain.filterTest(sum)) {
            ansiedadBrain.nextQuestion();
          } else {
            context.read<Resultados>().setAnsiedad(sum);
            storeAnsiedad(sum);
            Navigator.pushNamed(context, ResultadosScreen.id);
          }
        }
        answered = false;
      });
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe responder para continuar.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> storeAnsiedad(int result) async {
    Map<String, dynamic> dataList = {};
    String uid = context.read<UserState>().uid;

    var now = DateTime.now();
    var formatter = DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(now);

    String value = await DiadaModel().getAnyFieldById(uid, 'gad');

    if (value != '') dataList = jsonDecode(value);
    dataList[formattedDate] = result.toString();

    await DiadaModel().storeResultById(uid, 'gad', json.encode(dataList));
  }

  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            'Esta accción hará que se reinicie el cuestionario, ¿Está seguro?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Si'),
              onPressed: () {
                ansiedadBrain.reset();
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Answer> opciones = ansiedadBrain.getQuestionAnswersList();
    final questionIndex = ansiedadBrain.getQuestionsIndex();
    final questionsLength = ansiedadBrain.getQuestionsLength();
    print('Construyendo context $questionIndex');

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _showBackDialog();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Evaluación de Ansiedad',
            style: GoogleFonts.openSans(
                textStyle: Theme.of(context).textTheme.displayLarge,
                fontSize: 20,
                color: kPrimaryColor),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ansiedadBrain.hasQuestionLabel()
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          ansiedadBrain.getQuestionLabel().toString(),
                          textAlign: TextAlign.center,
                          style: kLabelTextStyle,
                        ),
                      )
                    : kEmptyBox,
                QuestionText(
                  // obteniendo el texto de la clase privada ansiedadBrain mediante encapsulación a travez del metodo getQuestionText
                  qText: ansiedadBrain.getQuestionText(),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                  child: Text(
                    '$questionIndex/$questionsLength',
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                buildListView(opciones, questionIndex),
                Row(
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kYellowColor,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Siguiente',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          checkAnswer();
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ListView buildListView(List<Answer> opciones, int questionIndex) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: opciones.length,
      itemBuilder: (ctx, i) {
        bool answerState = opciones[i].answerState;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          padding: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                ansiedadBrain.setAnswerValue(questionIndex, i);
                respuestasAns[questionIndex] =
                    ansiedadBrain.getAnswerValue(questionIndex, i);
                answered = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 28,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.grey.shade300),
                      shape: BoxShape.circle),
                  child: Text(
                    opciones[i].label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Text(
                    opciones[i].answerText,
                    textAlign: TextAlign.left,
                    style: kQuestionTextStyle,
                  ),
                ),
                answerState ? checkedIcon : unCheckedIcon
              ],
            ),
          ),
        );
      },
    );
  }
}
