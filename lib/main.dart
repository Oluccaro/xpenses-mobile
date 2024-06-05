import 'package:ds873/pages/listaviagens_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Gastos',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TripListScreen(),// Chamando a página TripListScreen como a página inicial

    );
  }
}

