import 'package:ds873/bars/top_bar.dart';
import 'package:ds873/pages/cadastrogastos_page.dart';
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
        primarySwatch: Colors.blue,
      ),
      home: ExpenseListScreen(),
    );
  }
}

class ExpenseListScreen extends StatelessWidget {
  final List<Expense> expenses = [
    Expense(type: 'Comida', value: 50.0),
    Expense(type: 'Transporte', value: 30.0),
    Expense(type: 'Entretenimento', value: 20.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemplateAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seus gastos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(expenses[index].type),
                    subtitle: Text('R\$ ${expenses[index].value.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.blueGrey,
        ),
      ),
    );
  }
}

class Expense {
  final String type;
  final double value;

  Expense({required this.type, required this.value});
}

