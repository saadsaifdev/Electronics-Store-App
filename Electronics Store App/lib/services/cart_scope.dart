import 'package:electrical_store_app/services/cart_controller.dart';
import 'package:flutter/widgets.dart';

class CartScope extends InheritedNotifier<CartController> {
  const CartScope({
    super.key,
    required CartController controller,
    required super.child,
  }) : super(notifier: controller);

  static CartController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CartScope>();
    assert(scope != null, 'CartScope is missing above this context.');
    return scope!.notifier!;
  }
}
