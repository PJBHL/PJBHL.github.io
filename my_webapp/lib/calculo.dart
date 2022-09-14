import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void calculo(String expressao) {

}

Widget test(String expressao) {
  return Container(
    color: Colors.blue,
    child: ListTile(
        leading: Icon(
          Icons.monetization_on_sharp,
          size: 40,
          color: Colors.green[700],
        ),
        title: Text("Test: $expressao"),
    ),
  );
}