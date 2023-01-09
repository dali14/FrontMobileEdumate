//import 'update_product_btn_widget.dart';
import 'package:flutter/material.dart';

import 'delete_product_btn_widget.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


class ProductDetailWidget extends StatelessWidget {
  final Product product;
  const ProductDetailWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            product.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 50,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //UpdateProductBtnWidget(product: product),
              DeleteProductBtnWidget(productId: product.id!)
            ],
          )
        ],
      ),
    );
  }
}


