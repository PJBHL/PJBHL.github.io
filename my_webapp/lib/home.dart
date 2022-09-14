// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
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
  TextEditingController limiteSuperior = TextEditingController();
  TextEditingController limiteInferior = TextEditingController();
  TextEditingController n = TextEditingController();
  TextEditingController expressao = TextEditingController();

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
                      controller: limiteInferior,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Limite Superior: ",
                        hintText: "... -1, 0, 1 ...",
                      ),
                      controller: limiteSuperior,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "N: ",
                        hintText: "... tender ao infinito ...",
                      ),
                      controller: n,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Expressão (fx): ",
                        hintText: "... x² + 1...",
                      ),
                      controller: expressao,
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        SaveUserExpression().saveLimInferior(limiteInferior);
                        SaveUserExpression().saveLimSuperior(limiteSuperior);
                        SaveUserExpression().saveN(n);
                        SaveUserExpression().saveExpression(expressao);
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
