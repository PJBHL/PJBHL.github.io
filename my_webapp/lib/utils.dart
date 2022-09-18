import 'package:flutter/material.dart';
import 'localStorage.dart';

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
