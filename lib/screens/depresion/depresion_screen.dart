import 'dart:convert';

import 'package:diada/classes/question.dart';
import 'package:diada/providers/resultados_provider.dart';
import 'package:diada/providers/user_provider.dart';
import 'package:diada/screens/alcoholismo/alcoholismo_splash_screen.dart';
import 'package:diada/services/diada_api.dart';
import 'package:diada/utils/constants.dart';
import 'package:diada/utils/depresion_brain.dart';
import 'package:diada/widgets/question_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Creo el nuevo objeto brain
DepresionBrain depresionBrain = DepresionBrain();

class DepresionScreen extends StatefulWidget {
  static const String id = 'depresion_screen';

  const DepresionScreen({super.key});
  @override
  _DepresionScreenState createState() => _DepresionScreenState();
}

class _DepresionScreenState extends State<DepresionScreen> {
  bool answered = false;
  int result = 0;
  Map<int, int> respuestasDep = {1: 0, 2: 0, 3: 0};

  void checkAnswer() {
    if (answered == true) {
      if (depresionBrain.isFinished() == true) {
        // Solo debe sumar los primeros nueve resultados
        int result = 0;
        for (int i = 1; i < respuestasDep.length; i++) {
          result = result + respuestasDep[i]!.toInt();
        }
        context.read<Resultados>().setDepresion(result);
        setState(() {
          storeDepresion(result);
          depresionBrain.reset();
          Navigator.pushNamed(context, AlcoholismoSplashScreen.id);
        });
      } else {
        // Continua con la siguiente pregunta
        setState(() {
          depresionBrain.nextQuestion();
        });
      }
      answered = false;
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

  Future<void> storeDepresion(int result) async {
    Map<String, dynamic> dataList = {};
    String uid = context.read<UserState>().uid;
    print('UID: $uid');
    var now = DateTime.now();
    var formatter = DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(now);

    String value = await DiadaModel().getAnyFieldById(uid, 'phq9');

    print('Base de datos : $value');

    if (value != '') dataList = jsonDecode(value);
    dataList[formattedDate] = result.toString();

    await DiadaModel().storeResultById(uid, 'phq9', json.encode(dataList));
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
                depresionBrain.reset();
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
    List<Answer> opciones = depresionBrain.getQuestionAnswersList();
    final questionIndex = depresionBrain.getQuestionsIndex();
    final questionsLength = depresionBrain.getQuestionsLength();

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
            'Evaluación de Depresion',
            style: GoogleFonts.openSans(
                textStyle: Theme.of(context).textTheme.headline1,
                fontSize: 20,
                color: kPrimaryColor),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                depresionBrain.hasQuestionLabel()
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          depresionBrain.getQuestionLabel().toString(),
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : kEmptyBox,
                QuestionText(
                  // obteniendo el texto de la clase privada depresionBrain mediante encapsulación a travez del metodo getQuestionText
                  qText: depresionBrain.getQuestionText(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    '$questionIndex/$questionsLength',
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: opciones.length,
                  itemBuilder: (ctx, i) {
                    bool answerState = opciones[i].answerState;
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 8.0),
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
                            depresionBrain.setAnswerValue(questionIndex, i);
                            respuestasDep[questionIndex] =
                                depresionBrain.getAnswerValue(questionIndex, i);
                            answered = true;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 28,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade300),
                                  shape: BoxShape.circle),
                              child: Text(
                                opciones[i].label,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16.0,
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
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal,
                                  color: kTextColor,
                                ),
                              ),
                            ),
                            answerState ? checkedIcon : unCheckedIcon
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
