// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'localStorage.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.cyan[100],
      title: const Text("Cálculo de Integrais Definidas - Soma de Riemann.", 
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

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

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: Form (
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField (
                controller: limiteInferior,
                decoration: const InputDecoration(
                  labelText: 'Limite Inferior: ',
                  hintText: '1... 100... -1',
                ),
              ),
              TextFormField(
                controller: limiteSuperior,
                decoration: const InputDecoration(
                  labelText: 'Limite Superior: ',
                  hintText: '1... 100... -1',
                ),
              ),
              TextFormField(
                controller: n,
                decoration: const InputDecoration(
                  labelText: 'Valor de N: ',
                  hintText: 'Tender ao infinito',
                ),
              ),
              TextFormField(
                controller: expressao,
                decoration: const InputDecoration(
                  labelText: 'Expressão: ',
                  hintText: '(-x² + 4x - 3)',
                ),
              ),
              const SizedBox(height: 25,),
              ElevatedButton(
                onPressed: () {
                  SaveUserExpression().saveLimInferior(limiteInferior);
                  SaveUserExpression().saveLimSuperior(limiteSuperior);
                  SaveUserExpression().saveN(n);
                  SaveUserExpression().saveExpression(expressao);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[100],
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                ),
                child: const Text("Calcular", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),),
              ),
            ],
          ),
        ),
        ),
    );
  }
}