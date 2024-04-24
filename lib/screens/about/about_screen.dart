import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  static const String id = 'about_screen';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  Future<void>? _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'https://www.project-diada.org/';
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Diada',
            style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'El proyecto DIADA (Detección y Atención Integrada de la Depresión y Uso de Alcohol en Atención Primaria) surge del proyecto de investigación de implementación titulado: "Scaling Up Science-based Mental Health Interventions in Latin America" Financiado por el National Institute of Mental Health, NIMH.',
                  style: kLoginTextStyle,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'En el proyecto de investigación de implementación propuesto, planeamos lanzar y evaluar un nuevo modelo de atención en salud mental en América Latina. Específicamente, en este nuevo modelo, proponemos:',
                  style: kLoginTextStyle,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        '1. Aprovechar la tecnología móvil en salud comportamental (con un enfoque principal en depresión y un enfoque secundario en el uso problemático del alcohol).',
                        style: kLoginTextStyle,
                      ),
                      Text(
                        '2. Lanzar nuevos modelos de capacitación y prestación servicios (que incluye la integración de tecnología en la prestación de servicios).',
                        style: kLoginTextStyle,
                      ),
                      Text(
                        '3. Lanzar y desarrollar un sistema integrado de gestión de datos para el seguimiento sistemático de los datos y la evaluación de desenlaces.',
                        style: kLoginTextStyle,
                      ),
                      Text(
                        '3. lanzar y desarrollar un grupo colaborativo de aprendizaje con organizaciones para integrar la salud mental en la atención primaria.',
                        style: kLoginTextStyle,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Lanzaremos este proyecto en múltiples sitios de atención primaria en varias partes de Colombia, con un plan para informar la posterior adopción en varios otros países latinoamericanos, incluidos Chile y Perú.',
                  style: kLoginTextStyle,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Conozca mas del proyecto en :',
                  style: kLoginTextStyle,
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _launched = _launchInBrowser(toLaunch);
                  }),
                  child: const Text(
                    'Proyecto Diada',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Agradecimientos y créditos',
                  style: kLoginTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Producto de apropiación social, financiado en el marco del Programa Jóvenes Investigadores e Innovadores del Ministerio de Ciencia Tecnología e Innovación de Colombia (Contrato 829 de 2018).',
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Desarrollado y diseñado por AlfamediaWEB',
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                    'Iconos de bebidas: Designed by Freepik and distributed by Flaticon'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    'Imagen de introducción: desperate-sad-depressed-feet-hands-2293377 by Anemome123 distributed by Pixabay'),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                    'Imagen de introducción: worried-girl-woman-waiting-sitting-413690 by RyanMcGuire distributed by Pixabay'),
                SizedBox(
                  height: 8.0,
                ),
                TextButton(
                  onPressed: () => setState(() {
                    _launched = _launchInBrowser(
                        'https://www.vecteezy.com/free-vector/depression');
                  }),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: const Text(
                    'Imagen de depresión: Depression Vectors by Vecteezy',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
