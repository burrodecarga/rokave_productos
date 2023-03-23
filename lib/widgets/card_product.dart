
import 'package:flutter/material.dart';
import 'package:rokave_productos/models/models.dart';

class CardProduct extends StatelessWidget {
  final Product product;

  const CardProduct({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 20, bottom: 50),
        width: double.infinity,
        height: 300,
        decoration: _BoxDecorationCustom(),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          _BackGroundImage(product.picture),
          ProductDetail(product: product),
          Positioned(top: 0, right: 0, child: _PriceTag(price: product.price)),
          if (!product.available)
          Positioned(top: 0, left: 0, child: _Available()),
        ]),
      ),
    );
  }

  BoxDecoration _BoxDecorationCustom() => BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 15,
          )
        ],
      );
}

class _Available extends StatelessWidget {
  

  
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 90,
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('No Disponible',
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 130,
      height: 70,
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomLeft: Radius.circular(20))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(price.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: _NewBoxDecoration(),
        width: double.infinity,
        height: 70,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            product.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.id ?? 'No ID',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ]),
      ),
    );
  }

  BoxDecoration _NewBoxDecoration() => const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), topRight: Radius.circular(20)));
}

class _BackGroundImage extends StatelessWidget {
  final String? url;

  const _BackGroundImage(this.url);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 300,
        color: Colors.amber,
        child: url == null
            ? const Image(
                image: AssetImage('assets/no-image.png'), fit: BoxFit.cover)
            : FadeInImage(
                placeholder: const AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
