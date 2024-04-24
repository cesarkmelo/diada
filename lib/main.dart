import 'package:diada/providers/resultados_provider.dart';
import 'package:diada/providers/user_provider.dart';
import 'package:diada/screens/user/login_screen.dart';
import 'package:diada/utils/constants.dart';
import 'package:diada/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Resultados(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => UserState(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Proyecto Diada',
          theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: kScaffoldColor,
              textTheme: GoogleFonts.openSansTextTheme(
                Theme.of(context).textTheme,
              )),
          home: LoginScreen(),
          routes: routes),
    );
  }
}
