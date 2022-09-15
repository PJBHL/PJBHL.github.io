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

  Future<String> getLimInferior() async {
    final prefs = await SharedPreferences.getInstance();
    String limInf = prefs.getString("limInferior") ?? "Sem Valor";
    print("Valor de Limite Inferior Recuperado: $limInf");
    return limInf;
  }

  Future<String> getLimSuperior() async {
    final prefs = await SharedPreferences.getInstance();
    String limSup = prefs.getString("limSuperior") ?? "Sem Valor";
    print("Valor de Limite Superior Recuperado: $limSup");
    return limSup;
  }

  Future<String> getExpression() async {
    final prefs = await SharedPreferences.getInstance();
    String expression = prefs.getString("expression") ?? "Sem Valor";
    print("Valor expression recuperado: $expression");
    return expression;
  }

  Future<String> getN() async {
    final prefs = await SharedPreferences.getInstance();
    String n = prefs.getString("n") ?? "Sem Valor";
    print("Valor de n recuperado: $n");
    return n;
  }

  getAllLocalStore() async {
    getLimInferior();
    getLimSuperior();
    getExpression();
    getN();
  }
}