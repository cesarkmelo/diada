import 'dart:convert';

import 'package:diada/classes/question.dart';
import 'package:diada/providers/resultados_provider.dart';
import 'package:diada/providers/user_provider.dart';
import 'package:diada/screens/ansiedad/ansiedad_splash_screen.dart';
import 'package:diada/services/diada_api.dart';
import 'package:diada/utils/alcoholismo_brain.dart';
import 'package:diada/utils/constants.dart';
import 'package:diada/widgets/btn_round_icon.dart';
import 'package:diada/widgets/info_dialog.dart';
import 'package:diada/widgets/info_trago.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//Creo el nuevo objeto brain
AlcoholismoBrain alcoholismoBrain = AlcoholismoBrain();

class AlcoholismoScreen extends StatefulWidget {
  static const String id = 'alcoholismo_screen';
  @override
  _AlcoholismoScreenState createState() => _AlcoholismoScreenState();
}

class _AlcoholismoScreenState extends State<AlcoholismoScreen> {
  bool answered = false;
  Map<int, int> respuestasAlc = {1: 0, 2: 0, 3: 0};
  var calcData = {};

  void checkAnswer() {
    if (answered == true) {
      setState(() {
        if (alcoholismoBrain.isFinished() == true) {
          // Termino encuesta: Guarda resultados y pasa al siguiente paso
          var values = respuestasAlc.values;
          var result = values.reduce((sum, element) => sum + element);
          context.read<Resultados>().setAlcoholismo(result);
          storeAlcoholismo(result);
          alcoholismoBrain.reset();
          Navigator.pushNamed(context, AnsiedadSplashScreen.id);
        } else {
          // Continua con la siguiente pregunta
          var sum = respuestasAlc[1]! + respuestasAlc[2]! + respuestasAlc[3]!;

          // Envio la suma de los primeros 3 items para filtar
          if (alcoholismoBrain.filterTest(sum)) {
            alcoholismoBrain.nextQuestion();
          } else {
            context.read<Resultados>().setAlcoholismo(0);
            storeAlcoholismo(0);
            Navigator.pushNamed(context, AnsiedadSplashScreen.id);
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

  Future<void> storeAlcoholismo(int result) async {
    Map<String, dynamic> dataList = {};
    String uid = context.read<UserState>().uid;

    var now = DateTime.now();
    var formatter = DateFormat('yyyy/MM/dd');
    String formattedDate = formatter.format(now);

    String value = await DiadaModel().getAnyFieldById(uid, 'audit');

    if (value != '') dataList = jsonDecode(value);
    dataList[formattedDate] = result.toString();

    await DiadaModel().storeResultById(uid, 'audit', json.encode(dataList));
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
                alcoholismoBrain.reset();
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
    List<Answer> opciones = alcoholismoBrain.getQuestionAnswersList();
    final questionIndex = alcoholismoBrain.getQuestionsIndex();
    final questionsLength = alcoholismoBrain.getQuestionsLength();

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _showBackDialog();
      },
      child: SafeArea(
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
                children: [
                  alcoholismoBrain.hasQuestionLabel()
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            alcoholismoBrain.getQuestionLabel().toString(),
                            style: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w800),
                          ),
                        )
                      : kEmptyBox,
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            // obteniendo el texto de la clase privada depresionBrain mediante encapsulación a travez del metodo getQuestionText
                            alcoholismoBrain.getQuestionText(),
                            textAlign: TextAlign.center,
                            style: kQuestionTextStyle,
                          ),
                        ),
                        alcoholismoBrain.hasQuestionInfo()
                            ? RoundIconButton(
                                icon: Icons.local_drink,
                                radius: 35,
                                iconSize: 20,
                                onPress: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return InfoDialog(
                                          title: 'Información',
                                          child: const TragoMuestras(),
                                        );
                                      });
                                },
                              )
                            : kEmptyBox,
                      ],
                    ),
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
                      final answerValue = opciones[i].answerState;
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
                              alcoholismoBrain.setAnswerState(questionIndex, i);
                              respuestasAlc[questionIndex] = alcoholismoBrain
                                  .getAnswerValue(questionIndex, i);
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
                              answerValue
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: kTextColor,
                                      size: 30,
                                    )
                                  : const Icon(
                                      Icons.radio_button_unchecked_outlined,
                                      color: Colors.grey,
                                      size: 30,
                                    )
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
      ),
    );
  }
}
