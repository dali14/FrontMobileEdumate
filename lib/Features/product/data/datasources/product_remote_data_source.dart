import 'dart:convert';

import '../../../../core/error/exeptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../product/data/models/Product_model.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<Unit> deleteProduct(int productId);
  Future<Unit> updateProduct(ProductModel productModel);
  Future<Unit> addProduct(ProductModel productModel);
}
const BASE_URL = "https://jsonplaceholder.typicode.com";

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "/products/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<ProductModel> postModels = decodedJson
          .map<ProductModel>((jsonPostModel) => ProductModel.fromJson(jsonPostModel))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addProduct(ProductModel productModel) async {
    final body = {
      "name": productModel.name,
      "price": productModel.price,
      "image": productModel.image
    };

    final response =
    await client.post(Uri.parse(BASE_URL + "/products/"), body: body );

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(int productId) async {
    final response = await client.delete(
      Uri.parse(BASE_URL + "/products/${productId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updateProduct(ProductModel productModel) async {
    final productId = productModel.id.toString();
    final body = {
      "name": productModel.name,
      "price": productModel.price,
      "title": productModel.image
    };

    final response = await client.patch(
      Uri.parse(BASE_URL + "/products/$productId"),
      body: body,
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}