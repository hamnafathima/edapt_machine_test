import 'package:edapt_machine_test/constants/color_class.dart';
import 'package:edapt_machine_test/constants/icon_class.dart';
import 'package:edapt_machine_test/constants/image_class.dart';
import 'package:edapt_machine_test/constants/textstyle_class.dart';
import 'package:edapt_machine_test/model/selected_model.dart';
import 'package:edapt_machine_test/provider/selected_provider.dart';
import 'package:edapt_machine_test/screens/cart_screen.dart';
import 'package:edapt_machine_test/screens/selected_dress.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MatchStyle extends StatefulWidget {
  const MatchStyle({super.key});

  @override
  State<MatchStyle> createState() => _MatchStyleState();
}

class _MatchStyleState extends State<MatchStyle> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SelectedProvider>(context, listen: false)
          .fetchSelectedData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedProvider = Provider.of<SelectedProvider>(context);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Match your style', style: TextstyleClass.white26_400),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF8F4F9),
                hintText: 'Search',
                hintStyle: TextstyleClass.grey16_400,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilterChipWidget(label: 'Trending Now', isSelected: true),
                FilterChipWidget(label: 'All', isSelected: false),
                FilterChipWidget(label: 'New', isSelected: false),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: selectedProvider.isDataLoading
                  ? const Center(child: CircularProgressIndicator())
                  : selectedProvider.selectedList.isEmpty
                      ? const Center(child: Text('No products available'))
                      : GridView.builder(
                          itemCount: selectedProvider.selectedList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            final product =
                                selectedProvider.selectedList[index];
                            return ProductCard(
                              name: product.title ?? '',
                              price: 'Rs. ${product.price}',
                              imageAsset:
                                  product.image ?? ImageClass.placeholderImage,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 0) {
            // Home tab (MatchStyle screen)
            setState(() {
              _currentIndex = index;
            });
          } else if (index == 1) {
            // Categories tab (SelectedDress screen)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SelectedDress()),
            );
          } else if (index == 2) {
            // Cart tab (CartScreen)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
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
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? ColorClass.lightPink : ColorClass.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String imageAsset;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageAsset,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorClass.backgroundColor,
        boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.network(widget.imageAsset, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited ? Colors.red : Colors.red,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.price,
                  style: const TextStyle(
                    color: ColorClass.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
