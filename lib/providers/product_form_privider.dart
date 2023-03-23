import 'package:flutter/material.dart';

import '../models/products.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider(this.product);

  bool isValidForm() {
    //print(product.name);
    return formKey.currentState?.validate() ?? false;
  }
}
