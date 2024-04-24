import 'dart:convert';

import 'package:diada/providers/resultados_provider.dart';
import 'package:diada/providers/user_provider.dart';
import 'package:diada/services/diada_api.dart';
import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../alcoholismo/alcoholismo_filter_screen.dart';
import 'depresion_screen.dart';

class DepresionFilterScreen extends StatefulWidget {
  static const String id = 'depresion_filter_screen';
  const DepresionFilterScreen({Key? key}) : super(key: key);

  @override
  _DepresionFilterScreenState createState() => _DepresionFilterScreenState();
}

class _DepresionFilterScreenState extends State<DepresionFilterScreen> {
  bool crit01 = false;
  bool crit02 = false;

  void checkAnswer() {
    if (crit01 == true || crit02 == true) {
      Navigator.pushNamed(context, DepresionScreen.id);
    } else {
      storeDepresion(0);
      depresionBrain.reset();
      context.read<Resultados>().setDepresion(0);
      Navigator.pushNamed(context, AlcoholismoFilterScreen.id);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Evaluación de depresión',
          style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: 20,
              color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Responda las siguientes preguntas',
                style: kQuestionTextStyle.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 6,
                      child: Text(
                        '¿Durante los últimos 30 días se ha sentido a menudo desanimado, deprimido o con pocas esperanzas?',
                        style: kQuestionTextStyle,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    FlutterSwitch(
                      activeText: "SI",
                      activeColor: kPrimaryColor,
                      inactiveText: "NO",
                      inactiveColor: Colors.grey,
                      width: 90.0,
                      height: 45.0,
                      valueFontSize: 20.0,
                      toggleSize: 40.0,
                      value: crit01,
                      borderRadius: 40.0,
                      padding: 4.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          crit01 = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 6,
                      child: Text(
                        '¿Durante los últimos 30 días ha sentido a menudo poco interés o placer al hacer cosas que habitualmente disfrutaba?',
                        style: kQuestionTextStyle,
                      ),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    FlutterSwitch(
                      activeText: "SI",
                      activeColor: kPrimaryColor,
                      inactiveText: "NO",
                      inactiveColor: Colors.grey,
                      width: 90.0,
                      height: 45.0,
                      valueFontSize: 20.0,
                      toggleSize: 40.0,
                      value: crit02,
                      borderRadius: 40.0,
                      padding: 4.0,
                      showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          crit02 = val;
                        });
                      },
                    ),
                  ],
                ),
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
    );
  }
}
