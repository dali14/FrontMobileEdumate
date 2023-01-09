
import 'package:dartz/dartz.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';

import '../../../../Core/error/failures.dart';
import '../repositories/product_repository.dart';



class UpdateProductUsecase {
  final ProductsRepository repository;

  UpdateProductUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Product product) async {
    return await repository.updateProduct(product);
  }
}


