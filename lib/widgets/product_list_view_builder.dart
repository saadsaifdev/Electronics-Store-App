import 'package:dio/dio.dart';
import 'package:electrical_store_app/models/product_lists_model.dart';
import 'package:electrical_store_app/services/product_services.dart';
import 'package:electrical_store_app/widgets/product_list_view.dart';
import 'package:flutter/material.dart';

class ProductsListViewBuilder extends StatefulWidget {
  const ProductsListViewBuilder({
    super.key,
    required this.category,
    this.brandFilter,
  });
  final String category;
  final String? brandFilter;

  @override
  State<ProductsListViewBuilder> createState() =>
      _ProductsListViewBuilderState();
}

class _ProductsListViewBuilderState extends State<ProductsListViewBuilder> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = _fetchProducts();
  }

  Future<List<ProductModel>> _fetchProducts() async {
    final products = await ProductServices(
      dio: Dio(),
    ).getCategoryProducts(category: widget.category);
    final brand = widget.brandFilter;
    if (brand == null) return products;
    return products
        .where((product) => product.brand.toLowerCase() == brand.toLowerCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: futureProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _statusSliver(
            child: const CircularProgressIndicator(
              backgroundColor: Colors.grey,
              color: Colors.blue,
            ),
          );
        }

        if (snapshot.hasError) {
          return _statusSliver(
            icon: Icons.error_outline,
            message: 'Something went wrong. Please try again later.',
          );
        }

        final products = snapshot.data ?? [];
        if (products.isEmpty) {
          return _statusSliver(
            icon: Icons.inventory_2_outlined,
            message: 'No products found in this category.',
          );
        }

        return ProductsListView(products: products);
      },
    );
  }

  Widget _statusSliver({Widget? child, IconData? icon, String? message}) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (child != null)
                child
              else ...[
                Icon(icon, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
