
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:integration_project_version2/Features/product/domain/usecases/get_all_products.dart';
import 'package:integration_project_version2/Core/error/failures.dart';
import 'package:integration_project_version2/Core/strings/failures.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


part 'products_event.dart';
part 'products_state.dart';


class ProductsBloc extends Bloc<ProductEvent, ProductsState> {
  final  GetAllProductUsecase getAllProducts;
  ProductsBloc({
    required this.getAllProducts,
  }) : super(ProductsInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetAllProductEvent) {
        emit(LoadingProductsState());

        final failureOrProducts = await getAllProducts();
        emit(_mapFailureOrProductsToState(failureOrProducts));
      } else if (event is RefreshProductEvent) {
        emit(LoadingProductsState());

        final failureOrProducts = await getAllProducts();
        emit(_mapFailureOrProductsToState(failureOrProducts));
      }
    });
  }
  ProductsState _mapFailureOrProductsToState(Either<Failure, List<Product>> either) {
    return either.fold(
      (failure) => ErrorProductsState(message: _mapFailureToMessage(failure)),
      (products) => LoadedProductsState(
        products: products,
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}


