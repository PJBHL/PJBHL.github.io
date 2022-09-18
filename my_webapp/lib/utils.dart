import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';

// Classe de estilização da appbar do front end.
class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.cyan[100],
      title: const Text(
        "Cálculo de Integrais Definidas - Soma de Riemann.",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

// Função para manipular a expressão f(x) de entrada do usuário e salva-la em um formato latex para exibição.
String createLatexExpression(String expression) {
  String input = expression.replaceAll(' ', '');

  if (input.contains('/')) {
    List<String> instancias;
    instancias = input.split(r'/');
    if (instancias.length == 2) {
      String dividendo = instancias[0];
      String divisor = instancias[1];
      instancias.remove(instancias[0]);
      instancias.insert(0, r'\' 'dfrac{$dividendo}');
      instancias.insert(1, '{$divisor}');
      instancias.remove(instancias[2]);
      input = instancias.join("");
      print("Teste input: $input");
    } else if (instancias.length == 3) {
      String dividendo = instancias[0];
      String divisor = instancias[1];
      String divisor2 = instancias[2];
      instancias.remove(instancias[0]);
      instancias.insert(0, r'\' 'dfrac{$dividendo}');
      instancias.remove(instancias[1]);
      instancias.insert(1, r'{\dfrac' '{$divisor}');
      instancias.remove(instancias[2]);
      instancias.insert(2, '{$divisor2}}');
      input = instancias.join("");
      print("Teste input: $input");
    }
  }

  if (input.contains('sqrt')) {
    input = input.replaceAll(r'sqrt', r'\sqrt');
    input = input.replaceAll(r'(', r'{');
    input = input.replaceAll(r')', r'}');
  }

  if (input.contains('pi')) {
    input = input.replaceAll(RegExp(r'pi'), r'\pi');
  }

  return input;
}

// Função para manipular a expressão f(x) de entrada do usuário de modo que o interpretador da biblioteca Math o entenda.
// Exemplo 1.1 - inserir -x causa conflito, portanto eu mudo para -1*x
// Exemplo 1.2 - inserir sen em portugues causaria erro, logo eu estou mudando sen para sin, sem que o usuário veja.
// Exemplo 1.3 - inserir "teta" é incompreensível para o interpretador, logo eu mudo para X.
String refactorExpression(String expression) {
  expression = expression.replaceAll(' ', '');

  if (expression.contains('-x')) {
    expression = expression.replaceAll(r'-x', '-1*x');
  }

  if (expression.contains('sen')) {
    expression = expression.replaceAll(r'sen', 'sin');
  }

  if (expression.contains('teta')) {
    expression = expression.replaceAll(r'teta', 'x');
  }

  return expression;
}

bool createErrorInfo(BuildContext context, String expression, num inf, num sup, n) {

  expression = refactorExpression(expression);

  bool error         = false;
  String errorStatus = "";

  try {
    expression.interpret();
  } on Exception {
    error = true;
    errorStatus = "Não entendi a sua expressão!\nExpressão: $expression\nVerifique as entradas aceitas.";
  }

  if(n < 0) {
    errorStatus = "N menor do que 0 -> $n";
    error = true;
  }

  if (error == true) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Erro na interpretação de algum dado de sua entrada:", 
      style: TextStyle(color: Colors.red,
      fontWeight: FontWeight.bold,
      fontSize: 20),),
      content: Text(errorStatus, style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  return error;
}