import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'alcoholismo_filter_screen.dart';

class AlcoholismoSplashScreen extends StatelessWidget {
  static const String id = 'alcoholismo_splash_screen';
  const AlcoholismoSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DIADA',
                  style: GoogleFonts.josefinSans(
                    textStyle: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 30,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Image.asset('images/dep_01.png'),
                ),
                Text(
                  'Consumo de alcohol',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: kTextColor),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Cuestionario de detección temprana y diagnóstico de depresión (episodio depresivo y trastorno depresivo recurrente) en adultos.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: kGreyColor),
                  ),
                ),
                const SizedBox(
                  height: 32.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AlcoholismoFilterScreen.id);
                  },
                  child: const Text(
                    'Empezar',
                    style: TextStyle(
                        color: kScaffoldColor,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.end,
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
