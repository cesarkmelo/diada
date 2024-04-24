import 'package:diada/providers/resultados_provider.dart';
import 'package:diada/providers/user_provider.dart';
import 'package:diada/screens/user/login_screen.dart';
import 'package:diada/services/diada_api.dart';
import 'package:diada/utils/alcoholismo_brain.dart';
import 'package:diada/utils/constants.dart';
import 'package:diada/utils/depresion_brain.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../utils/ansiedad_brain.dart';

DepresionBrain depresionBrain = DepresionBrain();
AlcoholismoBrain alcoholismoBrain = AlcoholismoBrain();
AnsiedadBrain ansiedadBrain = AnsiedadBrain();

class ResultadosScreen extends StatefulWidget {
  static const String id = 'resultados_screen';
  const ResultadosScreen({Key? key}) : super(key: key);

  @override
  _ResultadosScreenState createState() => _ResultadosScreenState();
}

class _ResultadosScreenState extends State<ResultadosScreen> {
  Future<bool> _isMale() async {
    String uid = context.read<UserState>().uid;
    String gender = await DiadaModel().getAnyFieldById(uid, 'genero');
    if (gender == 'Masculino')
      return true;
    else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    final depresionValue = context.watch<Resultados>().depValue;
    final alcoholismoValue = context.watch<Resultados>().alcValue;
    final ansiedadValue = context.watch<Resultados>().ansValue;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Resultados',
          style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 20,
              color: kPrimaryColor),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Depresión',
                                style: kQuestionTextStyle.copyWith(
                                  color: kScaffoldColor,
                                ),
                              ),
                              Text(
                                depresionBrain.getResultPhq9(depresionValue),
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: kYellowColor,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$depresionValue',
                              style: kQuestionTextStyle.copyWith(
                                color: kTextColor,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'PHQ9',
                              style: kQuestionTextStyle.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Recomendaciones de estilo de vida',
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: kYellowColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      depresionBrain.getRecomendationsPhq9(depresionValue),
                      overflow: TextOverflow.clip,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Consumo de alcohol',
                                style: kQuestionTextStyle.copyWith(
                                  color: kScaffoldColor,
                                ),
                              ),
                              Text(
                                alcoholismoBrain.getResultAudit(
                                    alcoholismoValue, _isMale),
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: kYellowColor,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$alcoholismoValue',
                              style: kQuestionTextStyle.copyWith(
                                color: kTextColor,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'AUDIT',
                              style: kQuestionTextStyle.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Recomendaciones de estilo de vida',
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: kYellowColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      alcoholismoBrain.getRecomendationsAudit(
                          alcoholismoValue, _isMale),
                      overflow: TextOverflow.clip,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
              decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ansiedad',
                                style: kQuestionTextStyle.copyWith(
                                  color: kScaffoldColor,
                                ),
                              ),
                              Text(
                                ansiedadBrain.getResultGad7(ansiedadValue),
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  color: kYellowColor,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 8.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$ansiedadValue',
                              style: kQuestionTextStyle.copyWith(
                                color: kTextColor,
                                fontSize: 40,
                              ),
                            ),
                            Text(
                              'GAD7',
                              style: kQuestionTextStyle.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Recomendaciones de estilo de vida',
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: kYellowColor, fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      ansiedadBrain.getRecomendationsGad7(ansiedadValue),
                      overflow: TextOverflow.clip,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                depresionBrain.reset();
                alcoholismoBrain.reset();
                ansiedadBrain.reset();
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: const Text(
                'Volver',
                style: kLoginTextStyle,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
