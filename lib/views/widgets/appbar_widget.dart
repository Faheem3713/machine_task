import 'package:flutter/material.dart';

PreferredSizeWidget appBarWidget(ValueNotifier cartCount) {
  return AppBar(
    actions: [
      const Icon(Icons.shopping_cart),
      ValueListenableBuilder(
          valueListenable: cartCount,
          builder: (context, value, _) {
            return Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Center(child: Text('$value')),
            );
          }),
      const SizedBox(
        width: 10,
      )
    ],
  );
}
