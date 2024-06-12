import 'dart:convert';

import 'package:ds873/bars/top_bar.dart';
import 'package:ds873/pages/cadastrogastos_page.dart';
import 'package:ds873/service/api-service.dart';
import 'package:flutter/material.dart';


class ExpenseListScreen extends StatefulWidget {
  
  int tripId;
  
  ExpenseListScreen(this.tripId);
  
   @override
  _ExpenseListScreenState createState() => _ExpenseListScreenState(this.tripId);
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  
  int tripId;

  _ExpenseListScreenState(this.tripId);

  // final ApiService apiService = ApiService(baseUrl: "http://localhost:9000");//web
  final ApiService apiService = ApiService(baseUrl: "https://charming-dingo-chief.ngrok-free.app");//mobile
  List<Expense> expenses = [];
  
  @override
  void initState() {
    super.initState();
    _fetchData();
  }


  void _fetchData() async {
    final response = await apiService.getRequest('/travel/$tripId/employee/1');
    String responseBody = utf8.decode(response.body.codeUnits);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(responseBody);
      List<dynamic> expensesData = responseData['expenses'];
      setState(() {
        try {
          expenses = expensesData.map((json) => Expense.fromJson(json)).toList();
        } catch (e) {
          print('erro$e');
        }
        });
      print(expenses);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

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
                    title: Text(expenses[index].description),
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
            MaterialPageRoute(builder: (context) => AddExpenseScreen(tripId: this.tripId)),
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
  int id;
  String description;
  double value;
  String image;
  String url;
    Expense({
    required this.id,
    required this.description,
    required this.value,
    required this.image,
    required this.url,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      description: json['description'] ?? '',
      value: json['value']?.toDouble() ?? '',  // Ensure value is parsed as double
      image: json['image'] ?? '',
      url: json['url'] ?? '',
    );
  }
}

