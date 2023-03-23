import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rokave_productos/screens/screens.dart';
import 'package:rokave_productos/services/services.dart';
import 'package:rokave_productos/widgets/widgets.dart';

import '../models/products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              productsService.selectedProduct =
                  productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            },
            child: CardProduct(
              product: productsService.products[index],
            )),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            productsService.selectedProduct = Product(
              available: false,
              name: '',
              price: 0.0,
            );
            Navigator.pushNamed(context, 'product');
          },
          child: const Icon(Icons.add)),
    );
  }
}
