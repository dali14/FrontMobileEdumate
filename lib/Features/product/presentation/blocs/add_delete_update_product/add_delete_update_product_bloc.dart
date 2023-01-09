

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../Core/error/failures.dart';
import '../../../../../Core/strings/failures.dart';

import '../../../../../core/strings/messages.dart';

import '../../../domain/usecases/add_product.dart';
import '../../../domain/usecases/delete_product.dart';
import '../../../domain/usecases/update_product.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


part 'add_delete_update_product_event.dart';
part 'add_delete_update_product_state.dart';





class AddDeleteUpdateProductBloc
    extends Bloc<AddDeleteUpdateProductEvent, AddDeleteUpdateProductState> {
  final AddProductUsecase addProduct;
  final DeleteProductUsecase deleteProduct;
  final UpdateProductUsecase updateProduct;
  AddDeleteUpdateProductBloc(
      {required this.addProduct,
      required this.deleteProduct,
      required this.updateProduct})
      : super(AddDeleteUpdateProductInitial()) {
    on<AddDeleteUpdateProductEvent>((event, emit) async {
      if (event is AddProductEvent) {
        emit(LoadingAddDeleteUpdateProductState());

        final failureOrDoneMessage = await addProduct(event.product);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is UpdateProductEvent) {
        emit(LoadingAddDeleteUpdateProductState());

        final failureOrDoneMessage = await updateProduct(event.product);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeleteProductEvent) {
        emit(LoadingAddDeleteUpdateProductState());

        final failureOrDoneMessage = await deleteProduct(event.productId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }

  AddDeleteUpdateProductState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateProductState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateProductState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
