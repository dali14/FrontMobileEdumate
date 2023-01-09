

import 'package:dartz/dartz.dart';
import '../../../../Core/error/failures.dart';
import '../../../../Core/network/network_info.dart';

import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/Product_model.dart';
import '../../../../core/error/exeptions.dart';
import 'package:integration_project_version2/utils.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';




typedef Future<Unit> DeleteOrUpdateOrAddProduct();


class ProductsRepositoryImpl implements ProductsRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl(
      {required this.remoteDataSource,
        required this.localDataSource,
        required this.networkInfo});



  @override

  Future<Either<Failure, List<Product>>> getAllProducts() async {

    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts();

        localDataSource.cacheProducts(remoteProducts);
        return Right(remoteProducts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProducts = await localDataSource.getCachedProducts();
        return Right(localProducts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addProduct(Product product) async {
    final ProductModel productModel = ProductModel(name: product.name, price: product.price, image: product.image, id: null);

    return await _getMessage(() {
      return remoteDataSource.addProduct(productModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteProduct(int productId) async {
    return await _getMessage(() {
      return remoteDataSource.deleteProduct(productId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateProduct(Product product) async {
    final ProductModel productModel =
    ProductModel(name: product.name, price: product.price, image: product.image, id: null);

    return await _getMessage(() {
      return remoteDataSource.updateProduct(productModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddProduct deleteOrUpdateOrAddProduct) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddProduct();
        return Right (unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}


