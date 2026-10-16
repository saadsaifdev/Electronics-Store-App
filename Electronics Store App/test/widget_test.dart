import 'package:electrical_store_app/models/product_lists_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ProductModel parses API values and supplies safe defaults', () {
    final product = ProductModel.fromJson({
      'thumbnail': 'https://example.com/product.png',
      'title': 'Example product',
      'category': 'electronics',
      'price': 99.5,
      'description': 'A sample product',
    });

    expect(product.image, 'https://example.com/product.png');
    expect(product.name, 'Example product');
    expect(product.category, 'electronics');
    expect(product.price, 99.5);
    expect(product.description, 'A sample product');
    expect(ProductModel.fromJson({}).name, isEmpty);
  });
}
