// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AppRoot]
class AppRootRoute extends PageRouteInfo<void> {
  const AppRootRoute({List<PageRouteInfo>? children})
      : super(AppRootRoute.name, initialChildren: children);

  static const String name = 'AppRootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppRoot();
    },
  );
}

/// generated route for
/// [Blank]
class BlankRoute extends PageRouteInfo<BlankRouteArgs> {
  BlankRoute({
    Key? key,
    Map<String, dynamic>? data,
    List<PageRouteInfo>? children,
  }) : super(
          BlankRoute.name,
          args: BlankRouteArgs(key: key, data: data),
          initialChildren: children,
        );

  static const String name = 'BlankRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BlankRouteArgs>(
        orElse: () => const BlankRouteArgs(),
      );
      return Blank(key: args.key, data: args.data);
    },
  );
}

class BlankRouteArgs {
  const BlankRouteArgs({this.key, this.data});

  final Key? key;

  final Map<String, dynamic>? data;

  @override
  String toString() {
    return 'BlankRouteArgs{key: $key, data: $data}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BlankRouteArgs) return false;
    return key == other.key &&
        const MapEquality<String, dynamic>().equals(data, other.data);
  }

  @override
  int get hashCode =>
      key.hashCode ^ const MapEquality<String, dynamic>().hash(data);
}

/// generated route for
/// [Cart]
class CartRoute extends PageRouteInfo<CartRouteArgs> {
  CartRoute({Key? key, required String country, List<PageRouteInfo>? children})
      : super(
          CartRoute.name,
          args: CartRouteArgs(key: key, country: country),
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CartRouteArgs>();
      return Cart(key: args.key, country: args.country);
    },
  );
}

class CartRouteArgs {
  const CartRouteArgs({this.key, required this.country});

  final Key? key;

  final String country;

  @override
  String toString() {
    return 'CartRouteArgs{key: $key, country: $country}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CartRouteArgs) return false;
    return key == other.key && country == other.country;
  }

  @override
  int get hashCode => key.hashCode ^ country.hashCode;
}

/// generated route for
/// [CartDetail]
class CartDetailRoute extends PageRouteInfo<CartDetailRouteArgs> {
  CartDetailRoute({
    Key? key,
    Map<String, dynamic>? data,
    List<PageRouteInfo>? children,
  }) : super(
          CartDetailRoute.name,
          args: CartDetailRouteArgs(key: key, data: data),
          initialChildren: children,
        );

  static const String name = 'CartDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CartDetailRouteArgs>(
        orElse: () => const CartDetailRouteArgs(),
      );
      return CartDetail(key: args.key, data: args.data);
    },
  );
}

class CartDetailRouteArgs {
  const CartDetailRouteArgs({this.key, this.data});

  final Key? key;

  final Map<String, dynamic>? data;

  @override
  String toString() {
    return 'CartDetailRouteArgs{key: $key, data: $data}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CartDetailRouteArgs) return false;
    return key == other.key &&
        const MapEquality<String, dynamic>().equals(data, other.data);
  }

  @override
  int get hashCode =>
      key.hashCode ^ const MapEquality<String, dynamic>().hash(data);
}

/// generated route for
/// [Home]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const Home();
    },
  );
}

/// generated route for
/// [Receipt]
class ReceiptRoute extends PageRouteInfo<ReceiptRouteArgs> {
  ReceiptRoute({
    Key? key,
    required Map<String, dynamic> receiptData,
    List<PageRouteInfo>? children,
  }) : super(
          ReceiptRoute.name,
          args: ReceiptRouteArgs(key: key, receiptData: receiptData),
          initialChildren: children,
        );

  static const String name = 'ReceiptRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ReceiptRouteArgs>();
      return Receipt(key: args.key, receiptData: args.receiptData);
    },
  );
}

class ReceiptRouteArgs {
  const ReceiptRouteArgs({this.key, required this.receiptData});

  final Key? key;

  final Map<String, dynamic> receiptData;

  @override
  String toString() {
    return 'ReceiptRouteArgs{key: $key, receiptData: $receiptData}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ReceiptRouteArgs) return false;
    return key == other.key &&
        const MapEquality<String, dynamic>().equals(
          receiptData,
          other.receiptData,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const MapEquality<String, dynamic>().hash(receiptData);
}
