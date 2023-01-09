
import 'package:dartz/dartz.dart';
import 'package:integration_project_version2/Core/error/failures.dart';
import '../repositories/product_repository.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';



class GetAllProductUsecase {
  final ProductsRepository repository;

  GetAllProductUsecase(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getAllProducts();
  }
}