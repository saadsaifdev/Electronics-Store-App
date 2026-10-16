import 'package:electrical_store_app/models/product_lists_model.dart';
import 'package:electrical_store_app/widgets/product_tile.dart';
import 'package:flutter/material.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ProductTile(productModel: products[index]),
            );
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
