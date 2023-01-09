// utils.dart

import 'package:integration_project_version2/features/product/domain/entities/product.dart';
import 'package:integration_project_version2/features/product/data/models/Product_model.dart';

Product productFromProductModel(ProductModel model) {
  return Product(
    id: model.id,
    name: model.name,
    price: model.price,
    image: model.image,
  );
}
