import 'package:electrical_store_app/constants.dart';
import 'package:electrical_store_app/widgets/product_list_view_builder.dart';
import 'package:flutter/material.dart';

class CategoryViewArgs {
  const CategoryViewArgs({
    required this.categoryName,
    required this.categorySlug,
    this.brandFilter,
  });

  final String categoryName;
  final String categorySlug;
  final String? brandFilter;
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    super.key,
    required this.categoryName,
    required this.categorySlug,
    this.brandFilter,
  });

  static const String id = 'CategoryView';

  final String categoryName;
  final String categorySlug;
  final String? brandFilter;

  static CategoryViewArgs? argsFromRoute(Object? arguments) {
    if (arguments is CategoryViewArgs) {
      return arguments;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName, style: kPacificoAppBarTitleDarkStyle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          ProductsListViewBuilder(
            category: categorySlug,
            brandFilter: brandFilter,
          ),
        ],
      ),
    );
  }
}
