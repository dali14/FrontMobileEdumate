
import '../../blocs/add_delete_update_product/add_delete_update_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';
import 'package:integration_project_version2/Features/product/domain/entities/product.dart';


class FormWidget extends StatefulWidget {
  final bool isUpdateProduct;
  final Product? product;
  const FormWidget({
    Key? key,
    required this.isUpdateProduct,
    this.product,
  }) : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageController = TextEditingController();


  @override
  void initState() {
    if (widget.isUpdateProduct) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price as String ;
      _imageController.text = widget.product!.image;

    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Name", multiLines: false, controller: _nameController),
            TextFormFieldWidget(
                name: "Price", multiLines: true, controller: _priceController),
            TextFormFieldWidget(
                name: "Image", multiLines: true, controller: _imageController),

            FormSubmitBtn(
                isUpdateProduct: widget.isUpdateProduct,
                onPressed: validateFormThenUpdateOrAddProduct, isUpdateproduct: null,),
          ]),
    );
  }

  void validateFormThenUpdateOrAddProduct() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final product = Product(
          id: widget.isUpdateProduct ? widget.product!.id : null,
          name: _nameController.text,
        image: _imageController.text, // utilisez le champs de saisie de texte correspondant à l'image
        price: double.parse(_priceController.text), // utilisez le champs de saisie de texte correspondant au prix
      );

      if (widget.isUpdateProduct) {
        BlocProvider.of<AddDeleteUpdateProductBloc>(context)
            .add(UpdateProductEvent(product: product));
      } else {
        BlocProvider.of<AddDeleteUpdateProductBloc>(context)
            .add(AddProductEvent(product: product));
      }
    }
  }
}
