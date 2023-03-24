import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rokave_productos/providers/product_form_privider.dart';
import 'package:rokave_productos/services/products_service.dart';
import 'package:rokave_productos/ui/input_decorations.dart';
import 'package:rokave_productos/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productsService.selectedProduct!),
      child: _ProductScreenBulid(productsService: productsService),
    );
  }
}

class _ProductScreenBulid extends StatelessWidget {
  const _ProductScreenBulid({
    required this.productsService,
  });

  final ProductsService productsService;

  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              CardImage(url: productsService.selectedProduct?.picture),
              Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          size: 30, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop())),
              Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined,
                        size: 30, color: Colors.white),
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 100);
                      if (pickedFile == null) {
                        print('No seleccionó nada');
                        return;
                      }
                      ///print('Tenemos imagen: XXXXX' + pickedFile.path);
                      productsService.updateSelectedImage(pickedFile.path);
                    },
                  )),
            ],
          ),
          _ProductForm(),
          const SizedBox(height: 100)
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: productsService.isSaving
            ? null
            : () async {
          productFormProvider.isValidForm();

                final String? imageUrl = await productsService.uploadImage();
                if (imageUrl != null) {
                  productFormProvider.product.picture = imageUrl;
                  ///print(imageUrl + 'XXXXX IMAGEN URL XXXXXX');
                }
          await productsService
              .saveOrCreateProduct(productFormProvider.product);
        },
        child: productsService.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save, size: 30),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final product = productFormProvider.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: productFormProvider.formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                    initialValue: product.name,
                    onChanged: (value) => product.name = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                    },
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'Nombre del Producto',
                        labelText: 'Nombre de Producto')),
                const SizedBox(height: 30),
                TextFormField(
                    initialValue: '${product.price}',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}'))
                    ],
                    onChanged: (value) {
                      if (double.tryParse(value) == null) {
                        product.price = 0;
                      }
                      product.price = double.parse(value);
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecorations.authInputDecoration(
                        hintText: 'Precio del Producto',
                        labelText: 'Precio de Producto')),
                const SizedBox(height: 10),
                SwitchListTile.adaptive(
                    title: const Text('Disponible'),
                    activeColor: Colors.indigo,
                    value: product.available,
                    onChanged: (value) {})
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white);
}
