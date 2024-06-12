import 'package:flutter/material.dart';
import 'scrap.dart';
import 'tela_scrap.dart';

class CupomFiscal extends StatefulWidget {
  final String scannedCode;

  const CupomFiscal({super.key, required this.scannedCode});

  @override
  State<CupomFiscal> createState() => _CupomFiscalState();
}

class _CupomFiscalState extends State<CupomFiscal> {
  Future<CupomFiscalData?>? _data;

  @override
  void initState() {
    super.initState();
    _data = Scraper.scrap(widget.scannedCode);
  } //Trocar a URL por uma variavel com a informação gerada do QR Code

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CupomFiscalData?>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return buildCupomFiscal(context, widget.scannedCode, data); // Chama o WidgetBuild da tela_scrap
        } else if (snapshot.hasError) {
          return Text('Erro ao obter dados: ${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
