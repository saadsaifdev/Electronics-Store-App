import 'package:dio/dio.dart';
import 'package:electrical_store_app/constants.dart';
import 'package:electrical_store_app/models/product_lists_model.dart';
import 'package:electrical_store_app/services/product_services.dart';
import 'package:electrical_store_app/views/product_details_view.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  static const String id = 'SearchView';

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final ProductServices _productServices = ProductServices(dio: Dio());
  List<ProductModel> _searchResults = [];
  List<ProductModel> _allProducts = [];
  bool _isLoading = true;
  bool _hasSearched = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    if (mounted) setState(() => _isLoading = true);
    try {
      final products = await _productServices.getAllProducts();
      if (!mounted) return;
      setState(() {
        _allProducts = products;
        _isLoading = false;
        _errorMessage = null;
      });
      _filterProducts(_searchController.text);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not load products. Please try again.';
      });
    }
  }

  void _filterProducts(String value) {
    final query = value.trim().toLowerCase();
    setState(() {
      _hasSearched = query.isNotEmpty;
      _searchResults = query.isEmpty
          ? []
          : _allProducts
                .where((product) => product.name.toLowerCase().contains(query))
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: const Text('Search', style: kPacificoAppBarTitleDarkStyle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              onChanged: _filterProducts,
              onSubmitted: _filterProducts,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _filterProducts(_searchController.text),
                ),
                labelText: 'Search',
                hintText: 'Search for any product you want',
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(child: _buildResults()),
        ],
      ),
    );
  }

  Widget _buildResults() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_errorMessage!),
            TextButton(
              onPressed: _loadProducts,
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }
    if (_hasSearched && _searchResults.isEmpty) {
      return const Center(child: Text('No products found.'));
    }
    if (!_hasSearched) {
      return const Center(child: Text('Search the product catalog.'));
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        return ListTile(
          leading: Image.network(
            product.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => const Icon(Icons.broken_image_outlined),
          ),
          title: Text(product.name),
          subtitle: Text('${product.price} IQD'),
          onTap: () => Navigator.pushNamed(
            context,
            ProductDetailsView.id,
            arguments: product,
          ),
        );
      },
    );
  }
}
