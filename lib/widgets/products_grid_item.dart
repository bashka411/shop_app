import 'package:flutter/material.dart';

import '../screens/product_details_screen.dart';
import '../models/product.dart';

class ProductsGridItem extends StatelessWidget {
  final Product product;
  ProductsGridItem(this.product);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: product),
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_rounded),
            ),
            title: Text(product.title),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart_rounded),
            ),
          ),
        ),
      ),
    );
  }
}