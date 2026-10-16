import 'package:electrical_store_app/models/product_lists_model.dart';
import 'package:flutter/foundation.dart';

class CartController extends ChangeNotifier {
  final Map<int, _CartEntry> _entries = {};

  List<CartItem> get items => _entries.values
      .map(
        (entry) => CartItem(product: entry.product, quantity: entry.quantity),
      )
      .toList(growable: false);

  int get itemCount =>
      _entries.values.fold(0, (sum, entry) => sum + entry.quantity);

  double get total => _entries.values.fold(
    0,
    (sum, entry) => sum + entry.product.price * entry.quantity,
  );

  void add(ProductModel product) {
    final entry = _entries.putIfAbsent(product.id, () => _CartEntry(product));
    entry.quantity++;
    notifyListeners();
  }

  void decrement(ProductModel product) {
    final entry = _entries[product.id];
    if (entry == null) return;
    if (entry.quantity <= 1) {
      _entries.remove(product.id);
    } else {
      entry.quantity--;
    }
    notifyListeners();
  }

  void remove(ProductModel product) {
    if (_entries.remove(product.id) != null) notifyListeners();
  }

  void clear() {
    if (_entries.isEmpty) return;
    _entries.clear();
    notifyListeners();
  }
}

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final ProductModel product;
  final int quantity;
  double get subtotal => product.price * quantity;
}

class _CartEntry {
  _CartEntry(this.product);

  final ProductModel product;
  int quantity = 0;
}
