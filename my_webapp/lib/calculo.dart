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

String calculoRiemman(String expression, num inf, num sup, n) {
  String result      = "";
  double delta       = deltaX(inf, sup, n);
  num xi             = 0.0;
  double intervalos  = 0.0;

  expression = refactorExpression(expression);
  print("Valor de delta: $delta");

  for(int i = 1; i <= n; i++) {
    xi = xI(inf, delta, i);
    result = expression.replaceAll(RegExp(r'x'), "$xi");
    var calc = result.interpret();
    intervalos += calc;
    //print("Resultado do replace: $result | Calculo: $calc | XI: $xi");
  }

  print("Valor intervalos da soma dos intervalos: $intervalos");
  print("Soma de Riemann: ${intervalos*delta}");
  double total = intervalos*delta;
  result = total.toString();

  return result;
}