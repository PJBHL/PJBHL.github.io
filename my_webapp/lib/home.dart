// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'calculo.dart';
import 'localStorage.dart';
import 'utils.dart';
import 'package:flutter_math_fork/flutter_math.dart';

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
  String input       = " ";
  bool  localStorage = false;
  double deltax      = 0.0;
  num xi             = 0.0;
  String riemann     = " ";

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

  Widget createResultContainer(String limInferior, String limSuperior, String input, double nNumber, double deltax, num xi, String resultado) {
    String supLatex = createLatexExpression(limSuperior.toString());
    String infLatex = createLatexExpression(limInferior.toString());
    String deltaN   = r'\''dfrac{$supLatex-$infLatex}{n}';
    String xiN      = '$infLatex + $deltaN * i';
    String result   = " ";

    if(input.contains('^2')) {
      result = input.replaceAll(r'x^2', '(x)^2');
      result = result.replaceAll(r'x', '$xiN');
    }
    if(input.contains('teta')) {
      result = result.replaceAll(r'teta', '$xiN');
    }
    if(input.contains('^x')) {
      result = input.replaceAll(r'x', '{$xiN}');
    }

    result = result.replaceAll(r'x', '$xiN');

    return Column(
      children: [
        const SizedBox(height: 8,),
        const Align(
          alignment: Alignment.center,
          child: Text("Resultados:", style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center,
            ),
        ),

        const SizedBox(height: 8,),
        
        Container(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                const Text("Integral interpretada de sua entrada: ",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Math.tex(r'\int_' '{$infLatex}^{$supLatex} $input ' r'\ \ dx',
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
            const Text("Soma de Riemman: ", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            Math.tex(r'\underset{n \to \infty}{lim} \sum_{i=1}^{n} \Delta x * f(x_i)', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Math.tex(r'\Delta x = ' r'\dfrac{b-a}{n}, \ portanto:' r'\Delta x =''$deltaN', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        Container(
        padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Math.tex('x_i = a + ' r'\Delta x * i, \ portanto: ''x_i=$xiN', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        Container(
        padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Math.tex('f(x_i) = ''$result', 
              textStyle: const TextStyle(
                fontSize: 20,
              ),),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                const Text("Somatório: ", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Math.tex(r'\underset{n \to \infty}{lim} \sum''_{i=1}^{$nNumber}''$deltaN * f($xiN)',
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
            Text("Resultado calculado: $resultado", style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(),
      body: Center(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Limite Inferior: ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... -1, 0, 1 ...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: infController,
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Limite Superior: ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... -1, 0, 1 ...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: supController,
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "N: ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... tender ao infinito ...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: nController,
                    ),
                    const SizedBox(height: 30,),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "Expressão (fx): ",
                        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        hintText: "... x² + 1...",
                      ),
                      textInputAction: TextInputAction.next,
                      controller: expressionInput,
                    ),
                    const SizedBox(height: 30,),
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
                        deltax       = deltaX(inf, sup, nNumber);
                        xi           = xI(inf, deltax, 1);
                        riemann = calculoRiemman(expression, inf, sup, nNumber);
                        createExpressionWidget();
                        input = createLatexExpression(expression);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[100],
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
              child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        if (localStorage == true)
                          createResultContainer(limInferior, limSuperior, input,
                              nNumber, deltax, xi, riemann)
                      ],
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}