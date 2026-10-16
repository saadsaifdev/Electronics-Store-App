import 'package:electrical_store_app/constants.dart';
import 'package:electrical_store_app/services/cart_controller.dart';
import 'package:electrical_store_app/services/cart_scope.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = CartScope.of(context);
    final items = cart.items;
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        title: const Text('Your Cart', style: kPacificoAppBarTitleDarkStyle),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: items.isEmpty
          ? const _EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        _CartProductCard(item: items[index], cart: cart),
                  ),
                ),
                _CartSummary(cart: cart),
              ],
            ),
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              size: 72,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore the store and add something you love.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(backgroundColor: kAccentColor),
              child: const Text('Continue shopping'),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartProductCard extends StatelessWidget {
  const _CartProductCard({required this.item, required this.cart});

  final CartItem item;
  final CartController cart;

  @override
  Widget build(BuildContext context) {
    final product = item.product;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.image,
              width: 84,
              height: 84,
              fit: BoxFit.contain,
              errorBuilder: (_, _, _) => const SizedBox(
                width: 84,
                height: 84,
                child: Icon(Icons.broken_image_outlined),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  '${item.subtotal.toStringAsFixed(2)} IQD',
                  style: const TextStyle(
                    color: kAccentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => cart.decrement(product),
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '${item.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      onPressed: () => cart.add(product),
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Remove item',
                      onPressed: () => cart.remove(product),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({required this.cart});

  final CartController cart;

  Future<void> _checkout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Place order?'),
        content: Text('Your total is ${cart.total.toStringAsFixed(2)} IQD.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Place order'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    cart.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order placed successfully.')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        18,
        20,
        18 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Items (${cart.itemCount})',
                style: TextStyle(color: Colors.grey.shade700),
              ),
              Text(
                '${cart.total.toStringAsFixed(2)} IQD',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: () => _checkout(context),
              style: FilledButton.styleFrom(backgroundColor: kAccentColor),
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
