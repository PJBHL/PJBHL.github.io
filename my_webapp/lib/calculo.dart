import 'package:function_tree/function_tree.dart';
import 'package:my_webapp/utils.dart';

// DeltaX = (b - a) / n.
// DeltaX = (sup - inf) / n.
double deltaX(num inf, sup, double n) {
  double result = (sup - inf) / n;
  return result;
}

// xI = a + DeltaX * i.
// xI = inf + DeltaX * i.
num xI(num inf, deltaX, int i) {
  num result = inf + deltaX * i;
  return result;
}

// Cálculo de Riemman.
// @param expression - expressão (fx) entrada pelo usuário.
// @param inf & sup  - limite inferior e superior da integral.
// @param n          - número de intervalos.
String calculoRiemman(String expression, num inf, num sup, n) {
  String result      = ""; // String que guardará o resultado.
  double delta       = deltaX(inf, sup, n); // Cálculo de Delta X
  num xi             = 0.0; // Futuro calculo de xi.
  double intervalos  = 0.0; // xi ... xn.

  // Manipulação da string para legibilidade do interpretador.
  expression = refactorExpression(expression);

  // Cálculo de Riemman propriamente dito, um somátorio nada mais é do que um for.
  // Somatório de i = 1 até n.
  // Cada iteração calcula o valor de um dos intervalos xi gerados.
  for(int i = 1; i <= n; i++) {
    xi = xI(inf, delta, i); // xi calculado a cada interação.
    result = expression.replaceAll(RegExp(r'x'), "$xi"); // substituir xi em "x" na string para o calculo.
    var calc = result.interpret(); // interpreta a string e devolve um resultado inteiro. Exemplo: "2+2" = 4.
    intervalos += calc; // Iterando o valor do resultado de cada intervalor de xi.
  }

  print("Valor intervalos da soma dos intervalos: $intervalos");
  print("Soma de Riemann: ${intervalos*delta}");
  double total = intervalos*delta; // Aplicação da formula: deltaX * f(xi) -> intervalos é o valor de xi + ... + xn.
  result = total.toString(); // converte o resultado para uma string.

  return result;
}