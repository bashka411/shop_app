import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import './products_grid_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavourites;

  ProductsGrid({this.showOnlyFavourites = false});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Products>(context);
    final products =
        showOnlyFavourites ? provider.favouriteProducts : provider.products;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductsGridItem(),
      ),
    );
  }
}
