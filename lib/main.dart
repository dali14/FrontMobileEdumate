import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:integration_project_version2/Features/product/presentation/blocs/Products/product_bloc.dart';
import 'package:integration_project_version2/Features/product/presentation/blocs/add_delete_update_product/add_delete_update_product_bloc.dart';
import 'package:integration_project_version2/Features/product/presentation/pages/product_page.dart';

import 'core/app_theme.dart';

import 'injection_container_product.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setupProductDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) => di.sl<ProductsBloc>()..add(GetAllProductEvent())),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdateProductBloc>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appTheme,
            title: 'Products App',
            home: ProductsPage()));
  }
}

