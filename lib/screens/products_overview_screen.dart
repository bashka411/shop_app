import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

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
            icon: Icon(Icons.more_vert_rounded),
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
        ],
      ),
      body: ProductsGrid(showOnlyFavourites: _showOnlyFavourites),
    );
  }
}
