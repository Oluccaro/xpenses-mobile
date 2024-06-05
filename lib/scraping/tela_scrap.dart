import 'package:flutter/material.dart';
import 'scrap.dart';

Widget buildCupomFiscal(CupomFiscalData data) {
  return Card(
    elevation: 5,
    margin: EdgeInsets.all(16),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da loja
          Text(
            data.nomeLoja,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Divider(thickness: 1),
          SizedBox(height: 5),

          // Lista de produtos
          Flexible(
            flex: 2,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.produtos.length,
              itemBuilder: (context, index) {
                final produto = data.produtos[index];
                return CadProd(produto: produto);
              },
            ),
          ),
          SizedBox(height: 5),
          Divider(thickness: 1),
          SizedBox(height: 5),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:'),
              Text(
                'R\$ ${data.total}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// Widget para cada produto
class CadProd extends StatelessWidget {
  final Produto produto;

  CadProd({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            //Widget para a descrição do produto
            width: 300,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10),
              child: Text('${produto.nome}:', style: TextStyle(fontSize: 14)),
            ),
          ),
          SizedBox(
            child: SizedBox(
              //Widget para a quantidade do produto
              width: 150,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(10),
                child: Text('Quantidade: ${produto.quantidade}',
                    style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
          SizedBox(
            //Widget para o valor do produto
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(10),
              child:
                  Text('R\$ ${produto.preco}', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
