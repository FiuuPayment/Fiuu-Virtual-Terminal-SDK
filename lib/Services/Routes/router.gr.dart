// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../Controller/AppRoot/app_root.dart' as _i1;
import '../../Controller/Blank/blank.dart' as _i6;
import '../../Controller/Cart/cart.dart' as _i5;
import '../../Controller/Cart/cart_detail.dart' as _i7;
import '../../Controller/Home/home.dart' as _i2;
import '../../Controller/OpenReport/open_report.dart' as _i4;
import '../../Controller/Receipt/receipt.dart' as _i3;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    AppRoot.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AppRoot());
    },
    Home.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.Home());
    },
    Receipt.name: (routeData) {
      final args = routeData.argsAs<ReceiptArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.Receipt(key: args.key, receiptData: args.receiptData));
    },
    OpenReport.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.OpenReport());
    },
    Cart.name: (routeData) {
      final args = routeData.argsAs<CartArgs>();
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.Cart(key: args.key, country: args.country));
    },
    Blank.name: (routeData) {
      final args = routeData.argsAs<BlankArgs>(orElse: () => const BlankArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.Blank(key: args.key, data: args.data));
    },
    CartDetail.name: (routeData) {
      final args = routeData.argsAs<CartDetailArgs>(
          orElse: () => const CartDetailArgs());
      return _i8.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.CartDetail(key: args.key, data: args.data));
    }
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(AppRoot.name, path: '/'),
        _i8.RouteConfig(Home.name, path: '/Home'),
        _i8.RouteConfig(Receipt.name, path: '/Receipt'),
        _i8.RouteConfig(OpenReport.name, path: '/open-report'),
        _i8.RouteConfig(Cart.name, path: '/Cart'),
        _i8.RouteConfig(Blank.name, path: '/Blank'),
        _i8.RouteConfig(CartDetail.name, path: '/cart-detail')
      ];
}

/// generated route for
/// [_i1.AppRoot]
class AppRoot extends _i8.PageRouteInfo<void> {
  const AppRoot() : super(AppRoot.name, path: '/');

  static const String name = 'AppRoot';
}

/// generated route for
/// [_i2.Home]
class Home extends _i8.PageRouteInfo<void> {
  const Home() : super(Home.name, path: '/Home');

  static const String name = 'Home';
}

/// generated route for
/// [_i3.Receipt]
class Receipt extends _i8.PageRouteInfo<ReceiptArgs> {
  Receipt({_i9.Key? key, required Map<String, dynamic> receiptData})
      : super(Receipt.name,
            path: '/Receipt',
            args: ReceiptArgs(key: key, receiptData: receiptData));

  static const String name = 'Receipt';
}

class ReceiptArgs {
  const ReceiptArgs({this.key, required this.receiptData});

  final _i9.Key? key;

  final Map<String, dynamic> receiptData;

  @override
  String toString() {
    return 'ReceiptArgs{key: $key, receiptData: $receiptData}';
  }
}

/// generated route for
/// [_i4.OpenReport]
class OpenReport extends _i8.PageRouteInfo<void> {
  const OpenReport() : super(OpenReport.name, path: '/open-report');

  static const String name = 'OpenReport';
}

/// generated route for
/// [_i5.Cart]
class Cart extends _i8.PageRouteInfo<CartArgs> {
  Cart({_i9.Key? key, required String country})
      : super(Cart.name,
            path: '/Cart', args: CartArgs(key: key, country: country));

  static const String name = 'Cart';
}

class CartArgs {
  const CartArgs({this.key, required this.country});

  final _i9.Key? key;

  final String country;

  @override
  String toString() {
    return 'CartArgs{key: $key, country: $country}';
  }
}

/// generated route for
/// [_i6.Blank]
class Blank extends _i8.PageRouteInfo<BlankArgs> {
  Blank({_i9.Key? key, Map<String, dynamic>? data})
      : super(Blank.name,
            path: '/Blank', args: BlankArgs(key: key, data: data));

  static const String name = 'Blank';
}

class BlankArgs {
  const BlankArgs({this.key, this.data});

  final _i9.Key? key;

  final Map<String, dynamic>? data;

  @override
  String toString() {
    return 'BlankArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i7.CartDetail]
class CartDetail extends _i8.PageRouteInfo<CartDetailArgs> {
  CartDetail({_i9.Key? key, Map<String, dynamic>? data})
      : super(CartDetail.name,
            path: '/cart-detail', args: CartDetailArgs(key: key, data: data));

  static const String name = 'CartDetail';
}

class CartDetailArgs {
  const CartDetailArgs({this.key, this.data});

  final _i9.Key? key;

  final Map<String, dynamic>? data;

  @override
  String toString() {
    return 'CartDetailArgs{key: $key, data: $data}';
  }
}
