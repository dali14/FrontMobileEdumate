import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';



abstract class ProductsRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, Unit>> deleteProduct(int id);
  Future<Either<Failure, Unit>> updateProduct(Product product);
  Future<Either<Failure, Unit>> addProduct(Product product);
}