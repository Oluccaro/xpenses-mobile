import 'dart:convert';

import 'package:ds873/bars/top_bar.dart';
import 'package:ds873/pages/ler_qrcode.dart';
import 'package:ds873/scraping/consumo_scrap.dart';
import 'package:ds873/scraping/scrap.dart';
import 'package:ds873/service/api-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddExpenseScreen extends StatefulWidget {
  String? urlCupom;
  CupomFiscalData? dataCupom;
  int? tripId;
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState(tripId: this.tripId, scannedUrl: this.urlCupom, dataCupom: this.dataCupom);

  AddExpenseScreen({this.tripId, this.urlCupom, this.dataCupom});
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String? _selectedExpense = 'Alimentação';
  String? _description = '';
  String? scannedUrl;
  CupomFiscalData? dataCupom;
  int? tripId;

  Expense expense = Expense();

  _AddExpenseScreenState({this.tripId, this.scannedUrl, this.dataCupom});

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  // final ApiService apiService = ApiService(baseUrl: "http://localhost:9000");//web
  final ApiService apiService = ApiService(baseUrl: "https://charming-dingo-chief.ngrok-free.app");//mobile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TemplateAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Cadastrar novo gasto',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição do Gasto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma descrição para o gasto';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedExpense,
                items: <String>['Alimentação', 'Transporte', 'Entretenimento', 'Saúde']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedExpense = newValue!;
                  });
                },
              ),
              SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      _openCameraForQR(context);
                    },
                    icon: Icon(Icons.qr_code_scanner),
                    label: Text('Ler QR Code',),

                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    icon: Icon(Icons.photo_library),
                    label: Text('Escolher da Galeria'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Voltar'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        this.expense.description = this._description;
                        this.expense.value = double.parse(this.dataCupom?.total.replaceAll(RegExp(','), '.') ?? '0');
                        this.expense.url = this.scannedUrl;
                        String expJson = jsonEncode(this.expense.toJson());
                        try{
                        this.apiService.postRequest("/travel/1/employee/1/expense", this.expense.toJson());
                        }catch(e){
                          print('$e');
                        }
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Salvar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openCameraForQR(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodePage(),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Handle the picked image
    }
  }
}

class Expense {
  int? id;
  String? description;
  double? value;
  String? image;
  String? url;
  
  Expense({
    this.id,
    this.description,
    this.value,
    this.image,
    this.url,
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

    // Convert Expense instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'value': value ?? 0,
      'url': url?? ''
    };
  }
}
