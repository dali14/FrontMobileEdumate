import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:integration_project_version2/Features/product/domain/entities/product.dart';

import '../../../../Core/error/exeptions.dart';
import '../models/Product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<Unit> cacheProducts(List<ProductModel> productModels);
}

const CACHED_PRODUCTS = "CACHED_PRODUCTS";

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheProducts(List<ProductModel> productModels) {
    List productModelsToJson = productModels
        .map<Map<String, dynamic>>((productModel) => productModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_PRODUCTS, json.encode(productModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonString = sharedPreferences.getString(CACHED_PRODUCTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<ProductModel> jsonToProductModels = decodeJsonData
          .map<ProductModel>((jsonProductModel) => ProductModel.fromJson(jsonProductModel))
          .toList();
      return Future.value(jsonToProductModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
