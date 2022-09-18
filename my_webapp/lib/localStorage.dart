import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUserExpression {

  // Salva no local storage o valor do limite inferior digitado.
  saveLimInferior(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("limInferior", valorDigitado);
  }

  // Salva no local storage o valor do limite superior digitado.
  saveLimSuperior(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("limSuperior", valorDigitado);
  }

  // Salva no local storage o valor de n digitado.
  saveN(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("n", valorDigitado);
  }

  // Salva no local storage o valor de f(x) digitado.
  saveExpression(TextEditingController digitado) async {
    String valorDigitado = digitado.text;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("expression", valorDigitado);
  }

  // Chama todas as funções para salvar os dados.
  saveInputData(TextEditingController inf, sup, n, expression) async {
    saveLimInferior(inf);
    saveLimSuperior(sup);
    saveN(n);
    saveExpression(expression);
  }

  // Remove os dados salvos no local storage.
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

  // Função para recuperar o valor de limite inferior e salva-lo em uma string.
  Future<String> getLimInferior() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String limInf = prefs.getString("limInferior") ?? "Sem Valor";
    return limInf;
  }

  // Função para recuperar o valor de limite superior e salva-lo em uma string.
  Future<String> getLimSuperior() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String limSup = prefs.getString("limSuperior") ?? "Sem Valor";
    return limSup;
  }
  
  // Função para recuperar o valor de n e salva-lo em um double.
  Future<double> getN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String n = prefs.getString("n") ?? "Sem Valor";
    double nNumber = double.parse(n);
    return nNumber;
  }

  // Função para recuperar o valor da expressão f(x) e salva-la em uma string.
  Future<String> getExpression() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String expression = prefs.getString("expression") ?? "Sem Valor";
    return expression;
  }
}