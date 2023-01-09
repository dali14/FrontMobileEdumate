import 'package:flutter/material.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


import '../../pages/product_add_update_page.dart';

class UpdateProductBtnWidget extends StatelessWidget {
  final Product product;
  const UpdateProductBtnWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductAddUpdatePage(
                isUpdateProduct: true,
                product: product,
              ),
            ));
      },
      icon: Icon(Icons.edit),
      label: Text("Edit"),
    );
  }
}
