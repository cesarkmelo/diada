import 'package:diada/providers/user_provider.dart';
import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:provider/provider.dart';

import '../user/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String id = 'intro_screen';
  const IntroScreen({Key? key}) : super(key: key);
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<ContentConfig> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      const ContentConfig(
        styleTitle: TextStyle(
          color: kPrimaryColor,
          fontSize: 30,
          fontWeight: FontWeight.w900,
        ),
        description:
            "Detección y Atención Integrada de la Depresión y Uso de Alcohol en Atención Primaria",
        styleDescription: TextStyle(
          color: kPrimaryColor,
          fontSize: 20,
        ),
        pathImage: "images/proyecto-diada-logo.png",
        heightImage: 300,
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      ContentConfig(
        title: "DIADA",
        styleTitle: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: kScaffoldColor,
            fontSize: 30,
            letterSpacing: 3.0,
          ),
        ),
        widgetDescription: const Padding(
          padding: EdgeInsets.only(top: 220.0),
          child: Text(
            'En esta aplicación podrá reconocer sus síntomas de depresión y consumo riesgoso de alcohol.\nUsted contestará preguntas sencillas de cuestionarios cortos; no le tomará más de cinco minutos.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kScaffoldColor,
              fontSize: 20,
            ),
          ),
        ),
        backgroundImage: "images/bg_slide02.jpg",
        backgroundBlendMode: BlendMode.colorBurn,
      ),
    );
    slides.add(
      ContentConfig(
        title: "DIADA",
        styleTitle: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: kScaffoldColor,
            fontSize: 30,
            letterSpacing: 3.0,
          ),
        ),
        widgetDescription: const Padding(
          padding: EdgeInsets.only(top: 220.0),
          child: Text(
            'Muestre los resultados a su médico en consulta, para conocer más de depresión y consumo riesgoso de alcohol.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kScaffoldColor,
              fontSize: 20,
            ),
          ),
        ),
        backgroundImage: "images/bg_slide03.jpg",
        backgroundBlendMode: BlendMode.colorBurn,
      ),
    );
  }

  void onDonePress() {
    Navigator.pushNamed(context, LoginScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, userState, _) => IntroSlider(
        listContentConfig: slides,
        onDonePress: onDonePress,
        renderNextBtn: const Text(
          'Siguiente',
          style: TextStyle(color: kYellowColor),
        ),
        renderDoneBtn: const Text(
          'Entrar',
          style: TextStyle(color: kYellowColor),
        ),
        renderSkipBtn: const Text(
          'Entrar',
          style: TextStyle(color: kYellowColor),
        ),
        onSkipPress: () {
          Navigator.pushNamed(context, LoginScreen.id);
        },
      ),
    );
  }
}
