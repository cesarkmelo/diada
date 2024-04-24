import 'package:flutter/material.dart';

import '../screens/alcoholismo/alcoholismo_filter_screen.dart';
import '../screens/alcoholismo/alcoholismo_splash_screen.dart';
import '../screens/alcoholismo/alhoholismo_screen.dart';
import '../screens/ansiedad/ansiedad_filter_screen.dart';
import '../screens/ansiedad/ansiedad_screen.dart';
import '../screens/ansiedad/ansiedad_splash_screen.dart';
import '../screens/depresion/depresion_filter_screen.dart';
import '../screens/depresion/depresion_screen.dart';
import '../screens/depresion/depresion_splash_screen.dart';
import '../screens/intro/intro_screen.dart';
import '../screens/resultados/resultados_screen.dart';
import '../screens/resultados/resultados_tabla_screen.dart';
import '../screens/user/login_screen.dart';

Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  IntroScreen.id: (context) => const IntroScreen(),
  LoginScreen.id: (context) => LoginScreen(),
  DepresionScreen.id: (context) => DepresionScreen(),
  DepresionSplashScreen.id: (context) => const DepresionSplashScreen(),
  DepresionFilterScreen.id: (context) => const DepresionFilterScreen(),
  AlcoholismoSplashScreen.id: (context) => const AlcoholismoSplashScreen(),
  AlcoholismoFilterScreen.id: (context) => const AlcoholismoFilterScreen(),
  AlcoholismoScreen.id: (context) => AlcoholismoScreen(),
  AnsiedadSplashScreen.id: (context) => const AnsiedadSplashScreen(),
  AnsiedadFilterScreen.id: (context) => const AnsiedadFilterScreen(),
  AnsiedadScreen.id: (context) => AnsiedadScreen(),
  ResultadosScreen.id: (context) => const ResultadosScreen(),
  ResultadosTablaScreen.id: (context) => const ResultadosTablaScreen(),
};
