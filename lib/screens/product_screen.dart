import 'package:flutter/material.dart';
import 'package:rokave_productos/ui/input_decorations.dart';
import 'package:rokave_productos/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              const CardImage(),
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
                    onPressed: () => Navigator.of(context).pop(),
                  )),
            ],
          ),
          _ProductForm(),
          const SizedBox(height: 100)
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save, size: 30),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del Producto',
                    labelText: 'Nombre de Producto')),
            const SizedBox(height: 30),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Precio del Producto',
                    labelText: 'Precio de Producto')),
            const SizedBox(height: 10),
            SwitchListTile.adaptive(
                title: Text('Disponible'),
                activeColor: Colors.indigo,
                value: true,
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
