import 'package:edapt_machine_test/constants/color_class.dart';
import 'package:edapt_machine_test/constants/icon_class.dart';
import 'package:edapt_machine_test/constants/image_class.dart';
import 'package:edapt_machine_test/constants/textstyle_class.dart';
import 'package:edapt_machine_test/provider/cart_provider.dart';
import 'package:edapt_machine_test/screens/cart_screen.dart';
import 'package:edapt_machine_test/screens/match_style.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectedDress extends StatefulWidget {
  const SelectedDress({super.key});

  @override
  State<SelectedDress> createState() => _SelectedDressState();
}

class _SelectedDressState extends State<SelectedDress> {
  int _currentIndex = 0;
  String selectedSize = 'xs';
  Color? selectedColor;

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                Image.asset(
                  ImageClass.selectedImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 10,
                  right: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Striped Pink Dress',
                        style: TextstyleClass.black20_600,
                      ),
                      const SizedBox(width: 85),
                      Text(
                        'Rs. 1,299.00',
                        style: TextstyleClass.dark16_600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Text(
                    'Size',
                    style: TextstyleClass.black20_600,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildCircle('XS'),
                      const SizedBox(width: 10),
                      _buildCircle('S'),
                      const SizedBox(width: 10),
                      _buildCircle('M'),
                      const SizedBox(width: 10),
                      _buildCircle('L'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Color',
                    style: TextstyleClass.black20_600,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildColorCircle(ColorClass.pink),
                      const SizedBox(width: 10),
                      _buildColorCircle(ColorClass.lightGreen),
                      const SizedBox(width: 10),
                      _buildColorCircle(ColorClass.coffee),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // Add to cart logic here
                cartProvider.addItem(
                  name: 'Striped Pink Dress',
                  price: 'Rs. 1,299.00',
                  image: ImageClass.selectedImage,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
              child: Container(
                height: 65,
                width: 400,
                color: ColorClass.lightRed,
                child: Center(
                  child: Text(
                    'Add to Cart',
                    style: TextstyleClass.white22_800,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const MatchStyle()),
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        selectedItemColor: ColorClass.lightOrange,
        unselectedItemColor: ColorClass.lightBlack,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  Widget _buildCircle(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        height: 39,
        width: 39,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
                color: isSelected ? Colors.red : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildColorCircle(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        height: 39,
        width: 39,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
        ),
      ),
    );
  }
}
