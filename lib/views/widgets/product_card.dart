import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../details_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key, required this.product, required this.cartCount});
  final ValueNotifier cartCount;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetails(product: product, cartCount: cartCount),
            ));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.network(product.image),
            Text(product.title),
            Text('₹${product.price.toString()}')
          ],
        ),
      ),
    );
  }
}
