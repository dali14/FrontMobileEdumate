import '../../blocs/add_delete_update_product/add_delete_update_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


class DeleteDialogWidget extends StatelessWidget {
  final int productId;
  const DeleteDialogWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdateProductBloc>(context).add(
              DeleteProductEvent(productId: productId),
            );
          },
          child: Text("Yes"),
        ),
      ],
    );
  }
}
