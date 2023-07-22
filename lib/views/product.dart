import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/model/model.dart';
import 'widgets/appbar_widget.dart';
import 'widgets/product_card.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  final ValueNotifier<int> cartCount = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(cartCount),
      body: FutureBuilder(
          future: getProduct(),
          builder: (context, snapShot) {
            return snapShot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : snapShot.hasData
                    ? GridView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: snapShot.data!.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1 / 1.9, crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          final data = snapShot.data![index];
                          return ProductCard(
                            cartCount: cartCount,
                            product: data,
                          );
                        },
                      )
                    : const SizedBox();
          }),
    );
  }

  Future<List<Product>> getProduct() async {
    const String url = 'https://fakestoreapi.com/products';
    final response = await http.get(Uri.parse(url));
    final result = (json.decode(response.body) as List)
        .map((e) => Product.fromJson(e))
        .toList();
    return result;
  }
}
