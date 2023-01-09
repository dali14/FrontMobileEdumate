

import 'package:integration_project_version2/utils.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel( {required int? id, required String name, required double price , required String image})
      : super(id: id, name: name, price: price, image: image) ;


  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], name: json['name'], price: json['price'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price , 'image': image};
  }
}


