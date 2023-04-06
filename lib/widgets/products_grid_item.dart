import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../screens/product_details_screen.dart';

class ProductsGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => Navigator.of(context).pushNamed(
                  ProductDetailsScreen.routeName,
                  arguments: product.id),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                onPressed: () => {
                  product.toggleFavouriteStatus(),
                },
                icon: Icon(
                  product.getFavouriteStatus()
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                ),
              ),
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
