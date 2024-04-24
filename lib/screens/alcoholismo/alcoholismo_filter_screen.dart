import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'alhoholismo_screen.dart';

class AlcoholismoFilterScreen extends StatefulWidget {
  static const String id = 'alcoholismo_filter_screen';
  const AlcoholismoFilterScreen({Key? key}) : super(key: key);

  @override
  _AlcoholismoFilterScreenState createState() =>
      _AlcoholismoFilterScreenState();
}

class _AlcoholismoFilterScreenState extends State<AlcoholismoFilterScreen> {
  void checkAnswer() {
    Navigator.pushNamed(context, AlcoholismoScreen.id);
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
    alcoholismoBrain.reset();
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
            'Consumo de alcohol',
            style: GoogleFonts.openSans(
                textStyle: Theme.of(context).textTheme.headline1,
                fontSize: 20,
                color: kPrimaryColor),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Debido a que el uso del alcohol puede afectar su salud e inferir con ciertos medicamentos y tratamientos, es importante que le hagamos algunas preguntas sobre su uso del alcohol.',
                        style: kQuestionTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16.0,
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
    );
  }
}
