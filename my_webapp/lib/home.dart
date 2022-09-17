// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'calculo.dart';
import 'localStorage.dart';
import 'utils.dart';
import 'package:flutter_math_fork/ast.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter_math_fork/tex.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<MyApp> {
  // Variáveis de controle de entrada de dados (formulário flutter).
  TextEditingController infController   = TextEditingController();
  TextEditingController supController   = TextEditingController();
  TextEditingController nController     = TextEditingController();
  TextEditingController expressionInput = TextEditingController();

  // Variáveis de controle de recuperação de dados e manipulação para calculos.
  String limInferior = " ";
  String limSuperior = " ";
  double nNumber     = 0.0;
  String expression  = " ";
  bool  localStorage = false;

  @override
  void initState() {
    super.initState();
    SaveUserExpression().removeSavedData();
  }

  void createExpressionWidget() {
    setState(() {
      localStorage = true;
    });
  }

  String createLatexExpression(String input) {
    input = input.replaceAll(' ', '');

    if(input.contains('sqrt')) {

    }

    if(input.contains('pi')){
      input = input.replaceAll(RegExp(r'pi'), '\pi');
    }

    return input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                color: Colors.blue,
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Limite Inferior: ",
                        hintText: "... -1, 0, 1 ...",
                      ),
                      controller: infController,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Limite Superior: ",
                        hintText: "... -1, 0, 1 ...",
                      ),
                      controller: supController,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "N: ",
                        hintText: "... tender ao infinito ...",
                      ),
                      controller: nController,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Expressão (fx): ",
                        hintText: "... x² + 1...",
                      ),
                      controller: expressionInput,
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () async {
                        SaveUserExpression().saveInputData(infController, supController, nController, expressionInput);
                        infController.clear(); supController.clear(); nController.clear(); expressionInput.clear();
                        limInferior  = await SaveUserExpression().getLimInferior();
                        num inf      = limInferior.interpret();
                        limSuperior  = await SaveUserExpression().getLimSuperior();
                        num sup      = limSuperior.interpret();
                        nNumber      = await SaveUserExpression().getN();
                        expression   = await SaveUserExpression().getExpression();
                        calculoRiemman(expression, inf, sup, nNumber);
                        createExpressionWidget();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.all(10),
                      ),
                      child: const Text(
                        "Calcular",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.green,
                width: double.infinity,
                child: Row(
                  children: <Widget> [
                    if(localStorage)
                      Math.tex(r'\int_''{$limInferior}^{$limSuperior} $expression')
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}