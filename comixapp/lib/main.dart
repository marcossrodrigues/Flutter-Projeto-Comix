import 'package:comixapp/telas/telaInicial.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comix - Leitor de Quadrinhos',
      debugShowCheckedModeBanner: false,
      home: TelaInicial(),
    );
  }
}
