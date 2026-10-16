import 'package:electrical_store_app/models/product_lists_model.dart';
import 'package:electrical_store_app/services/cart_controller.dart';
import 'package:electrical_store_app/services/cart_scope.dart';
import 'package:electrical_store_app/widgets/cart_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CartController cart;
  const product = ProductModel(
    id: 17,
    image: '',
    name: 'Test phone',
    category: 'smartphones',
    brand: 'Example',
    price: 125.5,
    description: '',
  );

  setUp(() => cart = CartController());
  tearDown(() => cart.dispose());

  test('adding a product updates line quantity, item count, and total', () {
    cart.add(product);
    cart.add(product);

    expect(cart.items, hasLength(1));
    expect(cart.items.single.quantity, 2);
    expect(cart.itemCount, 2);
    expect(cart.total, 251);
  });

  test(
    'increment, decrement, and remove notify listeners with current values',
    () {
      var notifications = 0;
      cart.addListener(() => notifications++);

      cart.add(product);
      cart.add(product);
      cart.decrement(product);

      expect(cart.items.single.quantity, 1);
      expect(cart.itemCount, 1);
      expect(cart.total, 125.5);

      cart.remove(product);
      expect(cart.items, isEmpty);
      expect(cart.itemCount, 0);
      expect(cart.total, 0);
      expect(notifications, 4);
    },
  );

  test('decrementing the last unit removes the product', () {
    cart.add(product);
    cart.decrement(product);

    expect(cart.items, isEmpty);
    expect(cart.itemCount, 0);
  });

  testWidgets('cart badge reflects controller updates immediately', (
    tester,
  ) async {
    await tester.pumpWidget(
      CartScope(
        controller: cart,
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(actions: [CartIconButton(onPressed: () {})]),
          ),
        ),
      ),
    );

    expect(find.text('1'), findsNothing);
    cart.add(product);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);

    cart.add(product);
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    cart.decrement(product);
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
  });
}
