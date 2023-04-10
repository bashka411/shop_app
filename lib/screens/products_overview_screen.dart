import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart_provider.dart';

enum FilterOptions { favourites, all }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions filterOption) {
              setState(
                () {
                  switch (filterOption) {
                    case FilterOptions.all:
                      _showOnlyFavourites = false;
                      break;
                    case FilterOptions.favourites:
                      _showOnlyFavourites = true;
                      break;
                  }
                },
              );
            },
            icon: Icon(Icons.filter_alt_rounded),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.all,
              ),
              PopupMenuItem(
                child: Text('Favourites'),
                value: FilterOptions.favourites,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) {
              return ItemCountBadge(
                  child: child,
                  value: cart.itemCount.toString(),
                  color: Theme.of(context).accentColor);
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart_rounded),
            ),
          ),
        ],
      ),
      body: ProductsGrid(showOnlyFavourites: _showOnlyFavourites),
    );
  }
}
