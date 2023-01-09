import '../../../../Core/widgets/loading_widget.dart';
import '../blocs/Products/product_bloc.dart';
import '../widgets/product_page/message_display_widget.dart';
import '../widgets/product_page/product_list_widget.dart';
import 'product_add_update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }

  AppBar _buildAppbar() => AppBar(title: Text('Products'));

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is LoadingProductsState) {
            return LoadingWidget();
          } else if (state is LoadedProductsState) {
            return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: ProductListWidget(products: state.products));
          } else if (state is ErrorProductsState) {
            return MessageDisplayWidget(message: state.message);
          }
          return LoadingWidget();
        },
      ),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<ProductsBloc>(context).add(RefreshProductEvent());
  }

  Widget _buildFloatingBtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductAddUpdatePage(
                  isUpdateProduct: false,
                )));
      },
      child: Icon(Icons.add),
    );
  }
}
