import 'package:electrical_store_app/firebase_options.dart'; // 👈 تمت إضافة هذا السطر
import 'package:electrical_store_app/services/cart_controller.dart';
import 'package:electrical_store_app/services/cart_scope.dart';
import 'package:electrical_store_app/views/cart_screen.dart';
import 'package:electrical_store_app/views/category_view.dart';
import 'package:electrical_store_app/views/home_view.dart';
import 'package:electrical_store_app/views/login_page.dart';
import 'package:electrical_store_app/views/product_details_view.dart';
import 'package:electrical_store_app/views/register_view.dart';
import 'package:electrical_store_app/views/search_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final CartController _cartController = CartController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ElectricalStoreApp());
}

class ElectricalStoreApp extends StatelessWidget {
  const ElectricalStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CartScope(
      controller: _cartController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginPage.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginPage(),
        );
      case RegisterView.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const RegisterView(),
        );
      case HomeView.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeView(),
        );
      case SearchView.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SearchView(),
        );
      case CartScreen.id:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CartScreen(),
        );
      case CategoryView.id:
        final args = CategoryView.argsFromRoute(settings.arguments);
        if (args == null) {
          return _invalidArgsRoute(settings);
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => CategoryView(
            categoryName: args.categoryName,
            categorySlug: args.categorySlug,
            brandFilter: args.brandFilter,
          ),
        );
      case ProductDetailsView.id:
        final product = ProductDetailsView.productFromRoute(settings.arguments);
        if (product == null) {
          return _invalidArgsRoute(settings);
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetailsView(product: product),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const LoginPage(),
        );
    }
  }

  Route<dynamic> _invalidArgsRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Unable to open this screen. Missing route arguments.'),
        ),
      ),
    );
  }
}
