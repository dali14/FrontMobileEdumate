import 'package:flutter/material.dart';

import '../widgets/product_detail_page/product_detail_widget.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: Text("Product Detail"),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ProductDetailWidget(product: product),
      ),
    );
  }
}
