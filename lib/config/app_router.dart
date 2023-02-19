import 'package:ecommerce/models/category_model.dart';
import 'package:ecommerce/models/models.dart';
import 'package:ecommerce/screens/cart/cart_screen.dart';
import 'package:ecommerce/screens/catalog/catalog_screen.dart';
import 'package:ecommerce/screens/home/home_screen.dart';
import 'package:ecommerce/screens/payment_selection/payment_selection_screen.dart';
import 'package:ecommerce/screens/product/product_screen.dart';
import 'package:ecommerce/screens/screens.dart';
import 'package:flutter/material.dart';

import '../screens/order_confirmation/order_confirmation_screen.dart';
import '../screens/profile/profile_screen.dart';


class AppRouter{
  static Route onGenerateRoute(RouteSettings settings){
    print('This is route: ${settings.name}');

    switch(settings.name){
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case SignupScreen.routeName:
        return SignupScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case CategoryScreen.routeName:
        return CategoryScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrderConfirmation.routeName:
        return OrderConfirmation.route();
      case PaymentSelection.routeName:
        return PaymentSelection.route();
      default:
        return _errorRoute();
    }
  }
  static Route _errorRoute(){
    return MaterialPageRoute(builder: (_) => Scaffold(appBar: AppBar(title: Text('Error')),),
    settings: RouteSettings(name: '/error'),);
  }

}