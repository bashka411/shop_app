import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../screens/product_details_screen.dart';

class ProductsGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            GridTile(
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
                  onPressed: () {
                    cart.addItem(
                        productId: product.id,
                        title: product.title,
                        price: product.price);
                  },
                  icon: Icon(Icons.add_shopping_cart_rounded),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              child: Chip(
                label: Text(
                  '\$${product.price}',
                  style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.titleLarge.color,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
