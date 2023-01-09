part of 'add_delete_update_product_bloc.dart';

abstract class AddDeleteUpdateProductEvent extends Equatable {
  const AddDeleteUpdateProductEvent();

  @override
  List<Object> get props => [];
}

class AddProductEvent extends AddDeleteUpdateProductEvent {
  final Product product;

  AddProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends AddDeleteUpdateProductEvent {
  final Product product;

  UpdateProductEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends AddDeleteUpdateProductEvent {
  final int productId;

  DeleteProductEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
