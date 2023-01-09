import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_project_version2/Features/product/presentation/pages/product_page.dart';
import '../../../../../Core/util/snackbar_message.dart';
import '../../../../../Core/widgets/loading_widget.dart';
import '../../blocs/add_delete_update_product/add_delete_update_product_bloc.dart';
import 'delete_dialog_widget.dart';



class DeleteProductBtnWidget extends StatelessWidget {
  final int productId;
  const DeleteProductBtnWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, productId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Delete"),
    );
  }

  void deleteDialog(BuildContext context, int productId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdateProductBloc,
              AddDeleteUpdateProductState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateProductState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => ProductsPage(),
                    ),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdateProductState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateProductState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(productId: productId);
            },
          );
        });
  }
}
