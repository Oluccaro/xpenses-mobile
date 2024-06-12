import 'package:ds873/pages/listadegastos_page.dart';
import 'package:ds873/service/api-service.dart';
import 'package:flutter/material.dart';
import 'package:ds873/bars/top_bar.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viagens e Gastos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TripListScreen(),
    );
  }
}


class TripListScreen extends StatefulWidget {
    @override
  _TripListScreenState createState() => _TripListScreenState();
}


class _TripListScreenState extends State<TripListScreen> {
  
  // final ApiService apiService = ApiService(baseUrl: "http://localhost:9000");//web
  final ApiService apiService = ApiService(baseUrl: "https://charming-dingo-chief.ngrok-free.app");//mobile
  List<Trip> trips = [];
  
  @override
  void initState() {
    super.initState();
    _fetchData();
  }


  void _fetchData() async {
    final response = await apiService.getRequest('/travel');
    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
        setState(() {
          trips = responseData.map((json) => Trip.fromJson(json)).toList();
        });
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
              'Suas viagens',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(trips[index].name),
                    subtitle: Text(
                        '${trips[index].startDate} - ${trips[index].endDate}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpenseListScreen(trips[index].id)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}


class Trip {
  int id;
  String name;
  String startDate;
  String endDate;
  String status;

  Trip({required this.id, required this.name, required this.startDate, required this.endDate, required this.status});

  factory Trip.fromJson(Map<String, dynamic> json) {

    return Trip(
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
    );
  }
}
