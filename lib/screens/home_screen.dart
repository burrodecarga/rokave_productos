// ignore_for_file: use_build_context_synchronously

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
    final authService = Provider.of<AuthService>(context, listen: false);
    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          onPressed: () async {
            await authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: const Icon(Icons.logout_outlined),
        ),
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
