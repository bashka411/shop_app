import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => {..._cartItems};

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.00;
    _cartItems.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void changeQuantity({@required String id, @required int inputQuantity}) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(
        id,
        (item) {
          var newQuantity = item.quantity + inputQuantity;
          if (newQuantity <= 0) {
            newQuantity = 1;
            HapticFeedback.lightImpact();
          }
          print('inputQuantity: $inputQuantity');
          print('newQuantity: $newQuantity');

          return CartItem(
            id: item.id,
            title: item.title,
            price: item.price,
            quantity: newQuantity,
          );
        },
      );
    }
    notifyListeners();
  }

  void addItem({
    @required String productId,
    @required String title,
    @required double price,
  }) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (item) => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: item.quantity + 1,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }
}
