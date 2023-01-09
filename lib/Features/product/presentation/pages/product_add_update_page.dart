import '../../../../Core/widgets/loading_widget.dart';
import 'product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/util/snackbar_message.dart';

import '../blocs/add_delete_update_product/add_delete_update_product_bloc.dart';
import '../widgets/product_add_update_page/form_widget.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';



class ProductAddUpdatePage extends StatelessWidget {
  final Product? product;
  final bool isUpdateProduct;
  const ProductAddUpdatePage({Key? key, this.product, required this.isUpdateProduct})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdateProduct ? "Edit Product" : "Add Product"));
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child:
          BlocConsumer<AddDeleteUpdateProductBloc, AddDeleteUpdateProductState>(
            listener: (context, state) {
              if (state is MessageAddDeleteUpdateProductState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const ProductsPage()),
                        (route) => false);
              } else if (state is ErrorAddDeleteUpdateProductState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdateProductState) {
                return const LoadingWidget();
              }

              return FormWidget(
                  isUpdateProduct: isUpdateProduct, product: isUpdateProduct ? product : null);
            },
          )),
    );
  }
}
