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