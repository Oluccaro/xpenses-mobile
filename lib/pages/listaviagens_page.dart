import 'package:ds873/pages/listadegastos_page.dart';
import 'package:flutter/material.dart';
import 'package:ds873/bars/top_bar.dart';

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

class TripListScreen extends StatelessWidget {
  final List<Trip> trips = [
    Trip(name: 'Viagem 1', startDate: '01/05/2024', endDate: '05/05/2024'),
    Trip(name: 'Viagem 2', startDate: '10/06/2024', endDate: '15/06/2024'),
    Trip(name: 'Viagem 3', startDate: '20/07/2024', endDate: '25/07/2024'),
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
                            builder: (context) => ExpenseListScreen()),
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
  final String name;
  final String startDate;
  final String endDate;

  Trip({required this.name, required this.startDate, required this.endDate});
}
