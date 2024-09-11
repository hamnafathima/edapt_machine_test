import 'package:edapt_machine_test/constants/color_class.dart';
import 'package:edapt_machine_test/constants/icon_class.dart';
import 'package:edapt_machine_test/constants/image_class.dart';
import 'package:edapt_machine_test/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: ColorClass.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorClass.backgroundColor,
        elevation: 0,
        actions: [
          Image.asset(ImageClass.profileImage),
          const SizedBox(width: 10),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Image.asset(IconClass.gridIcon),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: cartProvider.items.length,
        itemBuilder: (context, index) {
          final item = cartProvider.items[index];
          return ListTile(
            leading: Image.asset(item['image']!),
            title: Text(item['name']!),
            subtitle: Text(item['price']!),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                cartProvider.removeItem(index);
              },
            ),
          );
        },
      ),
    );
  }
}
