import 'dart:convert';

import 'package:diada/providers/user_provider.dart';
import 'package:diada/services/diada_api.dart';
import 'package:diada/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../alcoholismo/alhoholismo_screen.dart';
import '../depresion/depresion_screen.dart';

class ResultadosTablaScreen extends StatelessWidget {
  static const String id = 'tabla_resultos';
  const ResultadosTablaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> _isMale() async {
      String uid = context.read<UserState>().uid;
      String gender = await DiadaModel().getAnyFieldById(uid, 'genero');
      print(gender);
      if (gender == 'Masculino')
        return true;
      else
        return false;
    }

    String uid = context.read<UserState>().uid;
    var resultadosPhq9;
    var resultadosAudit;

    Future<dynamic> userDataPhq9() async {
      Map<String, dynamic> dataList = {};
      Map<String, dynamic> mapItem = {};
      List<dynamic> calcData = [];

      String phq9Value =
          await DiadaModel().getReversedDataFieldById(uid, 'phq9');
      if (phq9Value != '') dataList = jsonDecode(phq9Value);

      int index = 0;
      dataList.forEach((key, value) {
        if (index > dataList.length - 6) {
          mapItem['date'] = key;
          mapItem['value'] = value;
          calcData.add(mapItem);
          mapItem = {};
        }
        index++;
      });

      return calcData;
    }

    Future<dynamic> userDataAudit() async {
      Map<String, dynamic> dataList = {};
      Map<String, dynamic> mapItem = {};
      List<dynamic> calcData = [];

      String auditValue =
          await DiadaModel().getReversedDataFieldById(uid, 'audit');
      if (auditValue != '') dataList = jsonDecode(auditValue);

      int index = 0;
      dataList.forEach((key, value) {
        if (index > dataList.length - 6) {
          mapItem['date'] = key;
          mapItem['value'] = value;
          calcData.add(mapItem);
          mapItem = {};
        }
        index++;
      });

      return calcData;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tabla resultados',
          style: GoogleFonts.openSans(
              textStyle: Theme.of(context).textTheme.headline1,
              fontSize: 20,
              color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  FutureBuilder(
                    future: userDataPhq9(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          resultadosPhq9 = snapshot.data;
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Histórico de resultados de test de depresión',
                                  style: kLoginTextStyle,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 10.0, right: 10.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    padding: const EdgeInsets.all(8),
                                    itemCount: resultadosPhq9.length,
                                    itemBuilder: (context, index) {
                                      return ResultItem(
                                        testName: 'PHQ9',
                                        testResult:
                                            depresionBrain.getResultPhq9(
                                                int.parse(resultadosPhq9[index]
                                                    ['value'])),
                                        resultDate:
                                            '${resultadosPhq9[index]['date']}',
                                        resultValue:
                                            '${resultadosPhq9[index]['value']}',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else
                          return Container(
                            child: const Text('Esta vacio'),
                          );
                      } else
                        return Center(
                          child: Container(
                              width: 20,
                              height: 20,
                              child: const CircularProgressIndicator()),
                        );
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  FutureBuilder(
                    future: userDataAudit(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data != null) {
                          resultadosAudit = snapshot.data;
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Histórico de resultados de test de consumo de alcohol',
                                  style: kLoginTextStyle,
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 10.0, right: 10.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    padding: const EdgeInsets.all(8),
                                    itemCount: resultadosAudit.length,
                                    itemBuilder: (context, index) {
                                      return ResultItem(
                                        testName: 'AUDIT',
                                        testResult:
                                            alcoholismoBrain.getResultAudit(
                                                int.parse(resultadosAudit[index]
                                                    ['value']),
                                                _isMale),
                                        resultDate:
                                            '${resultadosAudit[index]['date']}',
                                        resultValue:
                                            '${resultadosAudit[index]['value']}',
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else
                          return Container(
                            child: const Text('Esta vacio'),
                          );
                      } else
                        return Center(
                          child: Container(
                            width: 0,
                            height: 0,
                          ),
                        );
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  final String testName;
  final String testResult;
  final String resultDate;
  final String resultValue;

  const ResultItem(
      {required this.testName,
      required this.testResult,
      required this.resultDate,
      required this.resultValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                testName,
                style: const TextStyle(fontSize: 14, color: kGreyColor),
              ),
              Text(
                testResult,
                style: const TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.only(bottom: 8.0),
          decoration: const BoxDecoration(
            color: kTextColor,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Column(
            children: [
              Text(
                resultValue,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
              Text(
                resultDate,
                style: const TextStyle(fontSize: 12, color: kYellowColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
