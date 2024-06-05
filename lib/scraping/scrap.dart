import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class Scraper {
  static Future<CupomFiscalData> scrap(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = parse(response.body);

      //Captura das informações da NF
      final nomeLoja = document.querySelector('#u20')!.text.trim(); //Loja

      final produtos = document.querySelectorAll('tbody> tr').map((produto) {
        final nome =
            produto.querySelector('span.txtTit2')!.text.trim(); //Produto

        final qtd = produto.querySelector('span.Rqtd')!.text;
        final quantidade = extrairValorDecimal(qtd); //Quantidade

        final val = produto.querySelector('span.RvlUnit')!.text;
        final preco = extrairValorDecimal(val); //Preço unitário

        return Produto(nome: nome, quantidade: quantidade, preco: preco);
      }).toList();
      final total = document
          .querySelector('#linhaTotal > span.totalNumb.txtMax')!
          .text
          .trim(); //Total NF

      return CupomFiscalData(
          nomeLoja: nomeLoja, produtos: produtos, total: total);
    } else {
      throw Exception('Erro ao obter dados do cupom: ${response.statusCode}');
    }
  }
}

//Classe dos produtos
class Produto {
  final String nome;
  final String quantidade;
  final String preco;

  Produto({required this.nome, required this.quantidade, required this.preco});
}

//Classe da Nota Fiscal (loja + produtos + total)
class CupomFiscalData {
  final String nomeLoja;
  final List<Produto> produtos;
  final String total;

  CupomFiscalData({
    required this.nomeLoja,
    required this.produtos,
    required this.total,
  });
}

//Função que visa eliminar caracteres de texto e manter apenas numéricos
String extrairValorDecimal(String text) {
  final parts = text.split(':');
  if (parts.length > 1) {
    return parts[1].trim();
  } else {
    return "";
  }
}
