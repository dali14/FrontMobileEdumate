

import 'package:dartz/dartz.dart';

import '../../../../Core/error/failures.dart';
import '../repositories/product_repository.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


class DeleteProductUsecase {
  final ProductsRepository repository;

  DeleteProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int productId) async {
    return await repository.deleteProduct(productId);
  }
}