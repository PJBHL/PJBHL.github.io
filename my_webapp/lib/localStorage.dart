import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUserExpression {

  saveLimInferior(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("limInferior", valorDigitado);
    print("Saved (Limite Inferior): $valorDigitado\n");
  }

  saveLimSuperior(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("limSuperior", valorDigitado);
    print("Saved (Limite Superior): $valorDigitado\n");
  }

  saveN(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("n", valorDigitado);
    print("Saved (n): $valorDigitado\n");
  }

  saveExpression(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("expression", valorDigitado);
    print("Saved (expressao): $valorDigitado\n");
  }

  removeSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("limInferior");
    prefs.remove("limSuperior");
    prefs.remove("n");
    prefs.remove("expression");
    print("Data Removed");
  }

  valueDelimitations(TextEditingController inf, TextEditingController sup) async {
    int infValue = int.parse(inf.text);
    int supValue = int.parse(sup.text);
    if(infValue >= supValue) {
    }
  }
}