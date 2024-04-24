import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';
import 'ansiedad_filter_screen.dart';

class AnsiedadSplashScreen extends StatelessWidget {
  static const String id = 'ansiedad_splash_screen';
  const AnsiedadSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Image.asset(
                      'images/dep_01.png',
                      height: queryData.size.height / 2.2,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ansiedad',
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
                      'El trastorno de ansiedad generalizada 7, es un cuestionario autoinformado para la detección y medición de la gravedad del trastorno de ansiedad generalizada.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                            fontSize: 18,
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
                      padding: const EdgeInsets.all(20),
                      backgroundColor: kPrimaryColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AnsiedadFilterScreen.id);
                    },
                    child: Text(
                      'Empezar'.toUpperCase(),
                      style: const TextStyle(
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
    );
  }
}
