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
          // Title
          Text(
            data.nomeLoja,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Divider(thickness: 1),
          SizedBox(height: 5),

          // Product list
          Flexible(
            flex: 2,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.produtos.length,
              itemBuilder: (context, index) {
                final produto = data.produtos[index];
                return ProductItem(produto: produto);
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

class ProductItem extends StatelessWidget {
  final Produto produto;

  ProductItem({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product name
          Expanded(
            child: Text(
              produto.nome,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(width: 10),
          // Quantity and price in a separate column
          Column(
            children: [
              Text(
                'Quantidade: ${produto.quantidade}',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 5),
              Text(
                'R\$ ${produto.preco}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
