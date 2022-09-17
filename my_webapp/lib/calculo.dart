import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:my_webapp/localStorage.dart';

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

String refactorExpression(String expression) {

  expression = expression.replaceAll(' ', '');

  if(expression.contains('-x')) {
    print("Expressao obtida em refactor(x): $expression");
    expression = expression.replaceAll(r'-x', '-1 * x');
    print("Depois do refactor: $expression");
  }

  if(expression.contains('sen')) {
    print("Expressao obtida em refactor(sen): $expression");
    expression = expression.replaceAll(r'sen', 'sin');
    print("Depois do refactor: $expression");
  }

  if(expression.contains('teta')) {
    print("Expressao obtida em refactor(teta): $expression");
    expression = expression.replaceAll(r'teta', 'x');
    print("Depois do refactor: $expression");
  }

  return expression;
}

String calculoRiemman(String expression, num inf, num sup, n) {
  String result = "";
  double delta  = deltaX(inf, sup, n);
  num xi        = 0.0;
  double total  = 0.0;

  expression = refactorExpression(expression);
  print("Valor de delta: $delta");

  for(int i = 1; i <= n; i++) {
    xi = xI(inf, delta, i);
    result = expression.replaceAll(RegExp(r'x'), "$xi");
    var calc = result.interpret();
    total += calc;
    //print("Resultado do replace: $result | Calculo: $calc | XI: $xi");
  }

  print("Valor total da soma dos intervalos: $total");
  print("Soma de Riemann: ${total*delta}");

  return result;
}