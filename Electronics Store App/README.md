# Electronics-Store-App

Electronics Store App is a Flutter e-commerce application for browsing electronics, viewing product details, and managing a shopping cart. It is also a learning project for Flutter UI development, API integration, authentication, navigation, and lightweight state management.

## Features

- Real-time, case-insensitive product search by name.
- Dynamic product categories, including smartphones, Samsung and Apple phones, laptops, tablets, accessories, and watches.
- Product catalog and category data loaded from the DummyJSON API.
- Product detail screens with images, descriptions, categories, and prices.
- Interactive shopping cart with quantity controls, item removal, a live item-count badge, and automatic total calculation.
- Clean light-themed UI with reusable widgets and loading, error, and empty states.
- Firebase email and password registration and login.

Checkout is a demonstration flow: it confirms the order locally but does not process payment or create a server-side order.

## Architecture and state management

The app separates screen UI, reusable widgets, data models, and API/cart services into focused directories under `lib/`. Named routes in `main.dart` connect the login, registration, home, search, category, product details, and cart screens.

`ProductServices` uses Dio to fetch and parse DummyJSON product data into `ProductModel` objects. `CartController` extends Flutter's `ChangeNotifier` and owns cart items, quantities, and totals. `CartScope` exposes the controller through an `InheritedNotifier` (an `InheritedWidget`), allowing screens and widgets to respond to cart updates without an external state-management package.

## Tech stack

- Flutter and Dart
- Dio and the DummyJSON products API
- Firebase Core and Firebase Authentication
- Material UI

## Project structure

```text
electrical_store_app/
├── assets/                 # Store images and Pacifico font
├── lib/
│   ├── helper/             # Shared UI helpers
│   ├── models/             # Product and category models
│   ├── services/           # Product API, cart controller, and CartScope
│   ├── views/              # App screens
│   ├── widgets/            # Reusable product, category, and cart widgets
│   ├── constants.dart      # Shared colors, typography, and app constants
│   ├── firebase_options.dart
│   └── main.dart           # Firebase setup, cart scope, and named routes
├── test/                   # Product model and cart tests
├── android/                # Android application and Firebase configuration
├── ios/                    # iOS application and CocoaPods configuration
├── macos/                  # macOS runner
├── web/                    # Web runner and manifest
├── linux/                  # Linux runner
├── windows/                # Windows runner
├── pubspec.yaml
└── README.md
```

## Setup and installation

### Requirements

- Flutter SDK matching the Dart SDK constraint in `pubspec.yaml`.
- Xcode and CocoaPods to run on iOS.
- A configured Firebase project with Email/Password Authentication enabled for account features.

### Run the app

```bash
git clone <repository-url>
cd electrical_store_app
flutter pub get
cd ios && pod install && cd ..
flutter run
```

Choose an available device or start an emulator before running `flutter run`. The iOS CocoaPods step is needed for iOS builds; it can be skipped when running on other platforms. Configure Firebase for your own project before using authentication.

## Author and credits

**Author:** Saad Sa— *Saad Electro*

Product catalog data is provided by [DummyJSON](https://dummyjson.com/). Authentication is powered by [Firebase](https://firebase.google.com/). Product imagery is loaded from Unsplash.
