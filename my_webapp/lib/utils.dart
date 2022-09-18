import 'package:flutter/material.dart';
import 'localStorage.dart';

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

String createLatexExpression(String expression) {
  String input = expression.replaceAll(' ', '');
  print("String em input: $input");

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
    print("Resultado de sqrt: $input");
  }

  if (input.contains('pi')) {
    input = input.replaceAll(RegExp(r'pi'), r'\pi');
    print("Resultado de pi: $input");
  }

  return input;
}

String refactorExpression(String expression) {
  expression = expression.replaceAll(' ', '');

  if (expression.contains('-x')) {
    print("Expressao obtida em refactor(x): $expression");
    expression = expression.replaceAll(r'-x', '-1*x');
    print("Depois do refactor: $expression");
  }

  if (expression.contains('sen')) {
    print("Expressao obtida em refactor(sen): $expression");
    expression = expression.replaceAll(r'sen', 'sin');
    print("Depois do refactor: $expression");
  }

  if (expression.contains('teta')) {
    print("Expressao obtida em refactor(teta): $expression");
    expression = expression.replaceAll(r'teta', 'x');
    print("Depois do refactor: $expression");
  }

  return expression;
}
