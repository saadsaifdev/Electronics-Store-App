import 'package:dio/dio.dart';
import 'package:electrical_store_app/models/product_lists_model.dart';

class ProductServices {
  final Dio dio;
  static const String baseUrl = 'https://dummyjson.com';

  ProductServices({required this.dio});

  Future<List<ProductModel>> getCategoryProducts({
    required String category,
  }) async {
    final response = await dio.get('$baseUrl/products/category/$category');

    return _parseProducts(response.data);
  }

  Future<List<ProductModel>> getAllProducts() async {
    final response = await dio.get('$baseUrl/products?limit=0');
    return _parseProducts(response.data);
  }

  List<ProductModel> _parseProducts(dynamic data) {
    if (data is! Map<String, dynamic>) {
      throw Exception('Unexpected response format from the API.');
    }

    final products = data['products'];
    if (products is! List) {
      throw Exception('Products list missing from the API response.');
    }

    return products
        .whereType<Map<String, dynamic>>()
        .map(ProductModel.fromJson)
        .toList();
  }
}
