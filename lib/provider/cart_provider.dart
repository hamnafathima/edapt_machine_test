import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, String>> cartItems = [];

  void addItem(
      {required String name, required String price, required String image}) {
    cartItems.add({
      'name': name,
      'price': price,
      'image': image,
    });
    notifyListeners();
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
    notifyListeners();
  }

  List<Map<String, String>> get items => cartItems;
}
