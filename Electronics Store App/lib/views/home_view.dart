import 'package:electrical_store_app/constants.dart';
import 'package:electrical_store_app/views/cart_screen.dart';
import 'package:electrical_store_app/views/search_view.dart';
import 'package:electrical_store_app/widgets/category_list_view_builder.dart';
import 'package:electrical_store_app/widgets/cart_icon_button.dart';
import 'package:electrical_store_app/widgets/product_list_view_builder.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String id = 'HomeView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(kAppTitle, style: kPacificoAppBarTitleStyle),
        actions: [
          CartIconButton(
            onPressed: () => Navigator.pushNamed(context, CartScreen.id),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchView.id);
            },
            icon: const Icon(Icons.search, color: kAccentColor),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: CategoryListViewBuilder()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ProductsListViewBuilder(category: 'smartphones'),
        ],
      ),
    );
  }
}
