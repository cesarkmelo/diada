import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'depresion_filter_screen.dart';

class DepresionSplashScreen extends StatelessWidget {
  static const String id = 'depresion_splash_screen';
  const DepresionSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        'DIADA',
                        style: GoogleFonts.josefinSans(
                          textStyle: const TextStyle(
                              fontSize: 30,
                              letterSpacing: 3.0,
                              color: kTextColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Image.asset(
                        'images/dep_01.png',
                        height: queryData.size.height / 2.4,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Depresión',
                      style: GoogleFonts.openSans(
                        textStyle: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: kTextColor),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      child: Text(
                        'Cuestionario de detección temprana y diagnóstico de depresión (episodio depresivo y trastorno depresivo recurrente) en adultos.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: kGreyColor),
                        ),
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
                        Navigator.pushNamed(context, DepresionFilterScreen.id);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
