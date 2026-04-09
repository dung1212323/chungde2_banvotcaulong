import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/news_screen.dart';
import 'screens/login_screen.dart';
import 'screens/promotions_screen.dart';
import 'screens/product_detail_screen.dart';
import 'models/product.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: MaterialApp(
        title: 'Li-Ning Shop',
        theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'Roboto',
        ),
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          if (settings.name == '/') {
            final category = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (_) => HomeScreen(initialCategory: category),
            );
          }
          if (settings.name == '/cart') {
            return MaterialPageRoute(builder: (_) => CartScreen());
          }
          if (settings.name == '/news') {
            return MaterialPageRoute(builder: (_) => NewsScreen());
          }
          if (settings.name == '/login') {
            return MaterialPageRoute(builder: (_) => LoginScreen());
          }
          if (settings.name == '/promotions') {
            return MaterialPageRoute(builder: (_) => PromotionsScreen());
          }
          if (settings.name == '/product-detail') {
            final product = settings.arguments as Product;
            return MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: product),
            );
          }
          return null;
        },
      ),
    );
  }
}
