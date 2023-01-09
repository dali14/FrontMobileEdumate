import '../../pages/product_detail_page.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/product.dart';

class ProductListWidget extends StatelessWidget {
  final List<Product> products;
  const ProductListWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(products[index].id.toString()),
          title: Text(products[index].name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(products[index].name, style: TextStyle(fontSize: 16),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailPage(product: products[index]),
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
    );
  }
}
