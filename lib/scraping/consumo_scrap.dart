import 'package:flutter/material.dart';
import 'scrap.dart';
import 'tela_scrap.dart';

class CupomFiscal extends StatefulWidget {
  @override
  State<CupomFiscal> createState() => _CupomFiscalState();
}

class _CupomFiscalState extends State<CupomFiscal> {
  Future<CupomFiscalData?>? _data;

  @override
  void initState() {
    super.initState();
    _data = Scraper.scrap(
        "https://www.fazenda.pr.gov.br/nfce/qrcode?p=41231243739437000154651100000693751161457949%7C2%7C1%7C1%7C839903E429C2EC5D88DBA3E64ED41770986FDF78");
  } //Trocar a URL por uma variavel com a informação gerada do QR Code

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CupomFiscalData?>(
      future: _data,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return buildCupomFiscal(data); // Chama o WidgetBuild da tela_scrap
        } else if (snapshot.hasError) {
          return Text('Erro ao obter dados: ${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }
}
