import 'package:electrical_store_app/models/product_category_model.dart';
import 'package:electrical_store_app/views/category_view.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final StoreCategoryModel category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          CategoryView.id,
          arguments: CategoryViewArgs(
            categoryName: category.categoryName,
            categorySlug: category.apiSlug,
            brandFilter: category.brandFilter,
          ),
        );
      },
      child: Container(
        height: 100,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(category.image),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Text(
            category.categoryName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
