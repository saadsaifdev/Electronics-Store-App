import 'package:electrical_store_app/models/product_category_model.dart';
import 'package:electrical_store_app/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryListViewBuilder extends StatelessWidget {
  const CategoryListViewBuilder({super.key});

  static const List<StoreCategoryModel> categories = [
    StoreCategoryModel(
      image:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',
      categoryName: 'All Smartphones',
      apiSlug: 'smartphones',
    ),
    StoreCategoryModel(
      image:
          'https://images.unsplash.com/photo-1592899677977-9c10ca588bbd?w=500',
      categoryName: 'Samsung',
      apiSlug: 'smartphones',
      brandFilter: 'Samsung',
    ),
    StoreCategoryModel(
      image:
          'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=500',
      categoryName: 'Apple iPhone',
      apiSlug: 'smartphones',
      brandFilter: 'Apple',
    ),
    StoreCategoryModel(
      image:
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500',
      categoryName: 'Laptops',
      apiSlug: 'laptops',
    ),
    StoreCategoryModel(
      image: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=500',
      categoryName: 'Tablets',
      apiSlug: 'tablets',
    ),
    StoreCategoryModel(
      image:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
      categoryName: 'Accessories',
      apiSlug: 'mobile-accessories',
    ),
    StoreCategoryModel(
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
      categoryName: 'Watches',
      apiSlug: 'mens-watches',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            CategoryCard(category: categories[index]),
      ),
    );
  }
}
