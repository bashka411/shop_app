import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  CartItem(this.id);

  void changeQuantity(BuildContext context,
      {@required String itemId, bool increment = true}) {
    final cart = Provider.of<Cart>(context, listen: false);
    cart.changeQuantity(id: itemId, inputQuantity: increment == true ? 1 : -1);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    final cartItem = cart.cartItems[id];

    return Dismissible(
      direction: DismissDirection.endToStart,
      background: Container(
        child: Icon(
          Icons.delete_rounded,
          size: 30,
          color: Colors.white,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.shade900,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.id);
      },
      key: ValueKey(cartItem.id),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              maxRadius: 30,
              child: FittedBox(child: Text('\$${cartItem.price}')),
            ),
            title: Text(cartItem.title),
            subtitle: Text('Total: ${(cartItem.price * cartItem.quantity)}'),
            trailing: FittedBox(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      changeQuantity(context, itemId: cartItem.id);
                    },
                    icon: Icon(Icons.add_rounded),
                  ),
                  Consumer<Cart>(
                    builder: (context, value, child) => Text(
                      '${cart.cartItems[id].quantity}',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      changeQuantity(context,
                          itemId: cartItem.id, increment: false);
                    },
                    icon: Icon(Icons.remove_rounded),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
