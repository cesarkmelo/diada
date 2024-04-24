import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/ansiedad_brain.dart';
import '../../utils/constants.dart';
import 'ansiedad_screen.dart';

AnsiedadBrain ansiedadBrain = AnsiedadBrain();

class AnsiedadFilterScreen extends StatefulWidget {
  static const String id = 'ansiedad_filter_screen';
  const AnsiedadFilterScreen({Key? key}) : super(key: key);

  @override
  _AnsiedadFilterScreenState createState() => _AnsiedadFilterScreenState();
}

class _AnsiedadFilterScreenState extends State<AnsiedadFilterScreen> {
  void checkAnswer() {
    setState(() {
      ansiedadBrain.reset();
    });
    Navigator.pushNamed(context, AnsiedadScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Evaluación de ansiedad',
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
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
                child: Text(
                  'Las siguientes frases describen problemas que usted puede haber padecido.\n\nRecapacite sobre las ocasiones en que los ha sufrido durante las 2 últimas semanas,'
                  'e indique cuál de las 4 opciones describe mejor la frecuencia con la que ha enfrentado estos problemas',
                  style:
                      kQuestionTextStyle.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
