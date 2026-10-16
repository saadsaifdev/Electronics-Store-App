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
    if (scope?.notifier case final controller?) return controller;
    throw FlutterError.fromParts([
      ErrorSummary('CartScope.of() called with no CartScope in the context.'),
      ErrorDescription(
        'Add a CartScope above this context to access the cart controller.',
      ),
    ]);
  }
}
