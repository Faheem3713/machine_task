import 'package:flutter/material.dart';
import 'package:machine_test/model/model.dart';
import 'widgets/appbar_widget.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails(
      {super.key, required this.product, required this.cartCount});
  final Product product;
  final ValueNotifier cartCount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(cartCount),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Image.network(
              product.image,
              height: 200,
            ),
            ListTile(
              title: Text(product.title),
              subtitle: Text('₹${product.price}'),
            ),
            Text(product.description),
            FilledButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')));
                cartCount.value++;
              },
              label: const Text('Add to Cart'),
              icon: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}
