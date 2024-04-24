import 'package:flutter/material.dart';

class Resultados with ChangeNotifier {
  int _depresionValue = 0;
  int _alcoholismoValue = 0;
  int _ansiedadValue = 0;

  String _ansiedadPath = '';

  int get depValue {
    return _depresionValue;
  }

  int get alcValue {
    return _alcoholismoValue;
  }

  int get ansValue {
    return _ansiedadValue;
  }

  String get ansPath {
    return _ansiedadPath;
  }

  void setDepresion(value) {
    _depresionValue = value;
    notifyListeners();
  }

  void setAlcoholismo(value) {
    _alcoholismoValue = value;
    notifyListeners();
  }

  void setAnsiedad(value) {
    _ansiedadValue = value;

    notifyListeners();
  }
}
